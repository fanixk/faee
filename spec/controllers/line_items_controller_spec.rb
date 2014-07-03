require 'spec_helper'

describe LineItemsController do

  describe 'POST create' do
    context 'with a product already in cart' do
      it 'does not save a new line item' do
        @cart = FactoryGirl.create(:cart)
        session[:cart_id] = @cart.id
        line_item = FactoryGirl.create(:line_item, cart_id: @cart.id)
        expect {
          post :create, product_id: line_item.product_id
        }.to_not change(LineItem, :count).by(1)
      end
    end

    context 'with a product not in cart' do
      it 'saves a line item' do
        line_item = FactoryGirl.create(:line_item)
        expect {
          post :create, product_id: line_item.product_id
        }.to change(LineItem, :count).by(1)
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @cart = FactoryGirl.create(:cart)
      session[:cart_id] = @cart.id
      @line_item = FactoryGirl.create(:line_item, cart_id: @cart.id)
    end

    it 'deletes the line item' do
      expect {
        delete :destroy, id: @line_item
      }.to change(LineItem, :count).by(-1)
    end

    it 'redirects to store#index' do
      delete :destroy, id: @line_item
      response.should redirect_to store_index_url
    end
  end

end
