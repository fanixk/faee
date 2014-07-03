class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Pay on Delivery", "Credit card" ].freeze
  attr_accessible :price, :address_id, :pay_type, :user_id, :state, :purchased_at, :shipped_at, :delivered_at, :canceled_at,
                  :card_number, :card_type, :card_verification, :card_expires_on, :card_first_name, :card_last_name


  # virtual attrs
  attr_accessor :card_number, :card_type, :card_verification, :card_expires_on, :card_first_name, :card_last_name, :invalid_payment

  before_save :save_price

  # hack for multiparameter bug of date_select
  composed_of :card_expires_on,
    :class_name => 'Date',
    :mapping => %w(Date to_s),
    :constructor => Proc.new { |date| (date && date.to_date) || Date.today },
    :converter => Proc.new { |value| value.to_s.to_date }

  validates :address_id, :user_id, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validate :validate_card, :on => :create, :if => :credit_card_payment?

  has_many :line_items, dependent: :destroy
  has_one :transaction, :class_name => 'OrderTransaction'
  belongs_to :user
  belongs_to :address

  scope :open_orders, -> { with_state(:open).includes(:line_items, :address, :user) }
  scope :shipped_orders, -> { with_state(:shipped).includes(:line_items, :address, :user) }
  scope :payed_orders, -> { with_state(:open, :shipped, :complete) }
  scope :preparing_orders, -> { with_state(:open, :shipped) }
  scope :complete_orders, -> { with_state(:complete ) }

  state_machine initial: :incomplete do
    event :purchase do
      transition :incomplete => :open
    end

    event :ship do
      transition :open => :shipped
    end

    event :cancel do
      transition :open => :canceled
    end

    event :resume do
      transition :canceled => :open
    end

    event :complete do
      transition :shipped => :complete
    end

    before_transition :incomplete => :open do |order|
      #.. process payment
      if order.credit_card_payment?
        gateway = ActiveMerchant::Billing::SpreedlyCoreGateway.new(
          :login=> Setting.gateway_login,
          :password => Setting.gateway_password,
          :gateway_token=> Setting.gateway_token
        )
        response = gateway.purchase(order.price_in_cents, order.credit_card, order.purchase_options)        
        OrderTransaction.create!(:action => "purchase", :amount => order.price_in_cents, :response => response, :order_id => order.id)
        order.invalid_payment = !response.success?
        response.success?
      end
      !order.invalid_payment
    end

    after_transition :incomplete => :open do |order|
      order.update_attributes(purchased_at: Time.zone.now)
    end

    after_transition :open => :shipped do |order|
      order.update_attributes(shipped_at: Time.zone.now)
    end

    after_transition :open => :canceled do |order|
      order.update_attributes(canceled_at: Time.zone.now)
    end

    after_transition :canceled => :open do |order|
      order.update_attributes(canceled_at: nil)
    end

    after_transition :shipped => :complete do |order|
      order.update_attributes(delivered_at: Time.zone.now)
      order.line_items.destroy_all
    end
  end

  def self.total_grouped_by_day(start)
    orders = payed_orders.where(purchased_at: start.beginning_of_day..Time.zone.now)
    orders = orders.group("date(purchased_at)")
    orders = orders.select("date(purchased_at) as purchased_at, count(*) as cnt, sum(price) as day_total_price")
    orders.group_by { |o| o.purchased_at.to_date }
  end

  def self.total_grouped_by_month(start)
    orders = payed_orders.where(purchased_at: start.beginning_of_month..Time.zone.now)
    orders = orders.group("date_trunc('month', purchased_at)")
    orders = orders.select("date_trunc('month', purchased_at) as purchased_at, count(*) as cnt, sum(price) as month_total_price")
    orders.group_by { |o| o.purchased_at.to_date }
  end

  def self.sales_period_ago(num = 30, period = 'days')
    where('purchased_at >= ?', num.send(period).ago).sum { |order| order.price }
  end

  def self.sales_by_period(period = 'month')
    where('purchased_at >= ?', Date.today.send("at_beginning_of_#{period}")).sum { |order| order.price }
  end

  def self.total_by_period(period = 'month')
    where('purchased_at >= ?', Date.today.send("at_beginning_of_#{period}")).count
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def credit_card_payment?
    pay_type == 'Credit card'
  end
  
  def price_in_cents
    (price*100).round
  end

  def purchase_options
    {
      :billing_address => {
        :name     => card_full_name,
        :address1 => address.full_address,
        :city     => Setting.billing_address_city,
        :country  => Setting.billing_address_country,
        :zip      => address.zipcode
        # :state    => 'NY',
      }
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => card_type,
      :number             => card_number, #test valid card 4111111111111111
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => card_first_name,
      :last_name          => card_last_name
    )
  end

  def card_full_name
    card_first_name + ' ' + card_last_name
  end

  def self.ransackable_attributes(auth_object=nil)
    %w(id price purchased_at canceled_at delivered_at shipped_at state) + _ransackers.keys
  end

  private
    def save_price
      self.price = self.total_price
    end
end
