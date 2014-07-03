class Address < ActiveRecord::Base
  attr_accessible :comment, :label, :region, :street_name, :street_num, :user_id, :zipcode, :phone, :latitude, :longitude
  
  validates_presence_of :user_id, :label, :street_name, :street_num, :region, :zipcode, :phone
  validates :label, :uniqueness => { :scope => :user_id }
  validates_numericality_of :phone
  
  geocoded_by :geo_address
  after_validation :geocode, :if => :geo_address_changed?
  
  has_many :orders
  belongs_to :user

  def full_address
    street_name + ' ' + street_num.to_s
  end

  def geo_address
    [full_address, region, zipcode].compact.join(', ')
  end

  def geo_address_changed?
    street_name_changed? or street_num_changed? or zipcode_changed? or region_changed?
  end
end
