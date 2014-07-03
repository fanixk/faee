require 'spec_helper'

describe Admin::OrdersController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of orders' do
      order = FactoryGirl.create(:order)
      get :index
      assigns(:orders).should eq([order])
    end

    it 'renders the :index view' do
      get :index 
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    before :each do
      @order = FactoryGirl.create(:order)
      xhr :get, :show, id: @order
    end

    it 'renders the show view' do
      response.should render_template :show
    end

    it 'assigns @product' do
      assigns(:order).should eq @order
    end
  end

  describe 'PUT #ship' do
    it 'redirects to orders' do
      order = FactoryGirl.create(:order, user_id: @user.id, state: 'open')
      put :ship, order_id: order.id
      response.should redirect_to admin_orders_path
      flash[:notice].should_not be_nil
    end
  end
  describe 'PUT #cancel' do
    it 'redirects to orders' do
      order = FactoryGirl.create(:order, user_id: @user.id, state: 'open')
      put :cancel, order_id: order.id
      response.should redirect_to admin_orders_path
      flash[:notice].should_not be_nil
    end
  end
  describe 'PUT #resume' do
    it 'redirects to orders' do
      order = FactoryGirl.create(:order, user_id: @user.id, state: 'canceled')
      put :resume, order_id: order.id
      response.should redirect_to admin_orders_path
      flash[:notice].should_not be_nil
    end
  end
  describe 'PUT #complete' do
    it 'redirects to orders' do
      order = FactoryGirl.create(:order, user_id: @user.id, state: 'shipped')
      put :complete, order_id: order.id
      response.should redirect_to admin_orders_path
      flash[:notice].should_not be_nil
    end
  end

end
