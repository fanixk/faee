class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  validates :quantity, :numericality => { greater_than_or_equal_to: 1 }
  default_scope includes(:product)
  
  def total_price
    product.price * quantity
  end
end
