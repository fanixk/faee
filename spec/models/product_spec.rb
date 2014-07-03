require 'spec_helper'

describe Product do
  it { should have_many(:line_items) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should_not allow_value(-1).for(:price) }
  it { should validate_presence_of(:category_id) }

  it "has a valid factory" do
    FactoryGirl.create(:product).should be_valid
  end
  
  describe "when category_name is called" do
    before { @product = FactoryGirl.create(:product) }

    it "returns the category name" do
      @product.category_name.should == @product.category.name
    end
  end

  describe "when a product is destroyed" do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    context "not referenced by line items" do
      it "destroys product" do
        @product.destroy
        @product.errors.messages.should == {}
      end
    end

    context "referenced by line items" do
      it "raises error" do
        @line_item = FactoryGirl.create(:line_item, product_id: @product.id)
        @product.destroy
        @product.errors.messages.should include(:base=>['Line Items present'])
      end
    end
  end

  it "should return ransack attrs" do
    Product.ransackable_attributes.should eq %w(description name price)
  end
end