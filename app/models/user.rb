class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :login

  #attr_protected :admin
  attr_accessor :login

  has_many :addresses
  has_many :orders
  
  validates_presence_of :username, :first_name, :last_name
  validates  :username, :uniqueness => { :case_sensitive => false }

  def full_name
    first_name + ' ' + last_name
  end

  def total_orders
    orders.count
  end
  
  def preparing_orders
    orders.where('state = ? OR state = ?', 'open', 'shipped')
  end

  def complete_orders
    orders.where('state = ?', 'complete')
  end

  def total_spent
    purchased_orders = orders.select { |order| !order.incomplete? }
    purchased_orders.sum { |order| order.price }
  end

  def self.total_customers
    where('admin is not true').count
  end

  def self.logins_by_period(period = 'day')
    where('last_sign_in_at >= ?', Date.today.send("at_beginning_of_#{period}")).count
  end

  def self.signups_by_period(period = 'month')
    where('created_at >= ?', Date.today.send("at_beginning_of_#{period}")).count
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.ransackable_attributes(auth_object=nil)
    %w(first_name last_name username email) + _ransackers.keys
  end
end
