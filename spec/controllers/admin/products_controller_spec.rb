require 'spec_helper'

describe Admin::ProductsController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of products' do
      product = FactoryGirl.create(:product)
      get :index
      assigns(:products).should eq([product])
    end

    it 'renders the :index view' do
      get :index 
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it 'renders the new view' do
      get :new
      response.should render_template :new
    end
  end

  describe 'GET #pdf' do
    it 'assigns @product' do
      product = FactoryGirl.create(:product)
      get :pdf
      assigns(:products).should eq [product]
    end
  end

  describe 'GET #edit' do
    before :each do
      @product = FactoryGirl.create(:product)
      get :edit, id: @product
    end

    it 'assigns @product' do
      assigns(:product).should eq(@product)
    end

    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        @category = FactoryGirl.create(:category)
      end

      it 'creates a new product' do
        expect { 
          post :create, product: FactoryGirl.attributes_for(:product, category_id: @category.id)
        }.to change(Product,:count).by(1)
      end

      it 'redirects to index' do
        post :create, product: FactoryGirl.attributes_for(:product, category_id: @category.id)
        response.should redirect_to admin_products_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new product' do
        expect {
          post :create , product: FactoryGirl.attributes_for(:product, name: nil)
        }.to_not change(Product, :count)
      end

      it 're-renders the new method' do
        post :create, product: FactoryGirl.attributes_for(:product, name: nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do 
      @product = FactoryGirl.create(:product)
    end

    context 'with valid attributes' do
      it 'located the requested product' do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(@product)
      end

      it "changes @product' attributes" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name:'Test')

        @product.reload
        @product.name.should eq('Test')
      end

      it 'redirects to index' do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to admin_products_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @product' do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: nil)
        assigns(:product).should eq(@product)
      end

      it 'does not change @product attrs' do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: 111)
        @product.reload
        @product.name.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: nil)
        response.should render_template :edit
      end
    end
  end


  describe 'DELETE destroy' do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    it 'deletes the product' do
      expect {
        delete :destroy, id: @product
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to products#index' do
      delete :destroy, id: @product
      response.should redirect_to admin_products_url
    end
  end
end
