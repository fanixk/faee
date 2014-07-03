require 'spec_helper'

describe StoreController do

  describe "GET 'index'" do
    
    it "populates an array of products" do
      product = FactoryGirl.create(:product)
      get :index
      assigns(:products).should eq([product])
    end

    context "when category_id is passed as param" do
      it "populates category" do
        category = FactoryGirl.create(:category)
        get :index, category_id: category.id
        assigns(:category).should eq(category)
      end
    end

    context "when category_id=0 is passed" do
      it "has an empty category" do
        get :index, category_id: 0
        assigns(:category).should eq('')
      end
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET show" do
      before :each do
        @product = FactoryGirl.create(:product)
        xhr :get, :show, id: @product
      end

      it "assigns the requested cart as @cart" do
        assigns(:product).should eq(@product)
      end

      it 'renders the #show view' do
        response.should render_template :show
      end
  end


end
