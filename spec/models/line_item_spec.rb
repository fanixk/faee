require 'spec_helper'

describe LineItem do
  it { should belong_to(:order) }
  it { should belong_to(:product) }
  it { should belong_to(:cart) }

  it { should validate_numericality_of(:quantity) }

  it { should_not allow_value(-1).for(:quantity) }
  
  before do
    @product = FactoryGirl.create(:product, price: 10)
    @cart = Cart.create
    @cart.add_product(@product.id)
    @line_item = LineItem.create(:product_id => @product.id, :cart_id => @cart.id)
  end

  it "should have valid factory" do
    @product.should be_valid
  end

  it "returns correct total price" do
    @line_item.quantity = 2
    @line_item.total_price.should == BigDecimal.new("20")
  end
end
