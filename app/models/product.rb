class Product < ActiveRecord::Base
  attr_accessible :description, 
                  :name, 
                  :price, 
                  :photo, 
                  :category_id

  has_many :line_items
  belongs_to :category
  
  has_attached_file :photo, 
                    :styles => { :large => "600x600", :medium => "300x300>", :small => "150x150>", :thumb => "50x50" },
                    :default_url => "/assets/products/missing/:style/missing.png",
                    :url    => "/assets/products/:id/:style/:basename.:extension",
                    :path   => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates :name, 
            :presence   => true, 
            :uniqueness => true
            
  validates :price, 
            :presence     => true, 
            :numericality => { :greater_than_or_equal_to => 0.01 }
            
  validates :category_id, 
            :presence => true

  validates_attachment  :photo, 
                      # :attachment_presence  => true, 
                        :attachment_size      => { :less_than => 5.megabytes },
                        :content_type         => { :content_type => ["image/jpeg", "image/png", "image/png"] }
  
  before_destroy :ensure_not_referenced_by_any_line_item

  def category_name
    category.name
  end

  def self.ransackable_attributes(auth_object=nil)
      %w(description name price) + _ransackers.keys
  end

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
