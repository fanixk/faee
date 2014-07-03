require 'spec_helper'

describe OrdersController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of orders' do
      order = FactoryGirl.create(:order, user_id: @user.id)
      order.purchase
      get :index
      assigns(:orders).should eq([order])
    end

    it 'renders the :index view' do
      get :index 
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    before :each do
      @cart = FactoryGirl.create(:cart)
      session[:cart_id] = @cart.id
      get :new
    end

    context 'with empty cart' do
      it 'redirects to store' do
        response.should redirect_to store_index_url
      end

      it 'sets flash notice' do
        flash[:notice].should eq 'Your cart is empty!'
      end
    end

    context 'with non empty cart' do
      it 'should render :new view' do
        line_item = FactoryGirl.create(:line_item, cart_id: @cart.id)
        get :new
        response.should render_template :new
      end
    end
  end

  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'does not save the new order' do
        expect {
          post :create , order: FactoryGirl.attributes_for(:order, address_id: nil)
        }.to_not change(Order, :count)
      end

      it 're-renders the new method' do
        post :create, order: FactoryGirl.attributes_for(:order, address_id: nil)
        response.should render_template :new
      end
    end
  end
end
