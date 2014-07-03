class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :products

  validates :name, 
            :presence   => true, 
            :uniqueness => true

  def self.ransackable_attributes(auth_object=nil)
    %w( name ) + _ransackers.keys
  end
end
