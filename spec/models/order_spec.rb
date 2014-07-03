require 'spec_helper'

describe Order do
  it { should validate_presence_of(:address_id) }
  it { should validate_presence_of(:user_id) }
  it { should ensure_inclusion_of(:pay_type).in_array([ "Pay on Delivery", "Credit card" ]) }
  it { should have_many(:line_items) }
  it { should have_one(:transaction) }
  it { should belong_to(:user) }
  it { should belong_to(:address) }

  it { should_not allow_mass_assignment_of(:invalid_payment) }

  it "should have valid factory" do
    order = FactoryGirl.create(:order)
    order.should be_valid
  end

  describe 'state' do
    before(:each) do
      @order = FactoryGirl.create(:order)
    end

    it "is open after purchasing" do
      @order.should_not be_open
      @order.purchase
      @order.should be_open
    end

    it "is not open after invalid purchase" do
      @order.invalid_payment = true
      @order.purchase
      @order.should_not be_open
    end

    it "is closed after canceling" do
      @order.purchase
      @order.cancel
      @order.should_not be_open
    end

    it "is open after resuming" do
      @order.purchase
      @order.cancel
      @order.resume
      @order.should be_open
    end

    it "is closed after shipping" do
      @order.purchase
      @order.ship
      @order.should_not be_open
    end

    it "queries open orders" do
      incomplete = FactoryGirl.create(:order, state: 'incomplete')
      @order.purchase
      canceled = FactoryGirl.create(:order, state: 'canceled')
      canceled.purchase
      canceled.cancel
      shipped = FactoryGirl.create(:order, state:'shipped')
      shipped.purchase
      shipped.ship
      Order.open_orders.should eq([@order])
    end
  end

  before do
    @cart = Cart.create
    @product = FactoryGirl.create(:product)
    @cart.add_product(@product.id)
    @order = FactoryGirl.create(:order)
    @order.add_line_items_from_cart(@cart)
  end

  it "adds line items from cart" do
    @order.line_items.should == @cart.line_items
  end

  it "calculates price from line_items total price" do
    @order.price = 1
    @order.save
    @order.price.should == @order.total_price
  end

  it "returns price in cents" do
    @order.price_in_cents.should == (@order.price*100).round
  end

  it "returns card full name as a string" do
    @order.card_first_name = 'Mpampis'
    @order.card_last_name = 'Sougias'
    @order.card_full_name.should eq 'Mpampis Sougias'
  end

  it "returns last month total sales" do
    order1 = FactoryGirl.build(:order, state: 'open', purchased_at: Time.zone.now)
    order1.save
    order2 = FactoryGirl.build(:order, state: 'complete', purchased_at: 4.months.ago)
    order2.save
    Order.sales_by_period.should eq order1.price
  end
end
