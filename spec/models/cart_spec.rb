require 'spec_helper'

describe Cart do
  it { should have_many(:line_items) }

  before do
    @cart = Cart.create
    @product = FactoryGirl.create(:product)
  end

  describe "a product is added" do
    it "returns current item" do
      @cart.add_product(@product.id)
      @cart.line_items.first.product_id.should == @product.id
    end

    it "increases quantity if the product already exists" do
      @line_item = @cart.add_product(@product.id)
      @line_item.save
      @line_item = @cart.add_product(@product.id)
      @line_item.save
      @line_item.quantity.should == 2
    end
  end

  it "returns total price" do
    product2 = FactoryGirl.create(:product)
    @cart.add_product(@product.id)
    @cart.add_product(product2.id)

    @cart.total_price.should == product2.price + @product.price
  end

  it 'returns item count' do
    product2 = FactoryGirl.create(:product)
    @cart.add_product(@product.id)
    @cart.add_product(product2.id)
    @cart.item_count.should == 2
  end

end
