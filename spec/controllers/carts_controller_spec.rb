require 'spec_helper'

describe CartsController do

  describe "GET show" do
    context "with existant cart" do
      before :each do
        @cart = FactoryGirl.create(:cart)
        session[:cart_id] = @cart.id
        get :show, id: @cart
      end

      it "assigns the requested cart as @cart" do
        assigns(:cart).should eq(@cart)
      end

      it 'renders the #show view' do
        response.should render_template :show
      end
    end

    context 'with non existant cart' do
      before :each do 
        @cart = FactoryGirl.create(:cart)
        session[:cart_id] = @cart.id
      end

      it 'redirects to store' do
        get :show, id: rand(100) + @cart.id
        response.should redirect_to store_index_url
        flash[:notice].should eq 'Invalid cart.'
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @cart = FactoryGirl.create(:cart)
      session[:cart_id] = @cart.id
    end

    it 'deletes the cart' do
      expect {
        delete :destroy, id: @cart
      }.to change(Cart, :count).by(-1)
    end

    it 'redirects to store index' do
      delete :destroy, id: @cart
      response.should redirect_to store_index_url
    end
  end

end
