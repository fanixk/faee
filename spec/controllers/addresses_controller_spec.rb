require 'spec_helper'

describe AddressesController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of addresses' do
      address = FactoryGirl.create(:address, user_id: @user.id)
      get :index
      assigns(:addresses).should eq([address])
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

  describe 'GET #edit' do
    before :each do
      @address = FactoryGirl.create(:address)
      get :edit, id: @address
    end

    it 'assigns @address' do
      assigns(:address).should eq(@address)
    end

    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new address' do
        expect { 
          post :create, address: FactoryGirl.attributes_for(:address, user_id: @user.id)
        }.to change(Address,:count).by(1)
      end

      it 'redirects to index' do
        post :create, address: FactoryGirl.attributes_for(:address, user_id: @user.id)
        response.should redirect_to addresses_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new address' do
        expect {
          post :create , address: FactoryGirl.attributes_for(:address, region: nil)
        }.to_not change(Address, :count)
      end

      it 're-renders the new method' do
        post :create, address: FactoryGirl.attributes_for(:address, region: nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do 
      @address = FactoryGirl.create(:address, user_id: @user.id)
    end

    context 'with valid attributes' do
      it 'located the requested address' do
        put :update, id: @address, address: FactoryGirl.attributes_for(:address)
        assigns(:address).should eq(@address)
      end

      it "changes @address' attributes" do
        put :update, id: @address, address: FactoryGirl.attributes_for(:address, street_name:'Test', 
                                              street_num: 1, user_id: @user.id)

        @address.reload
        @address.street_name.should eq('Test')
        @address.street_num.should eq 1
      end

      it 'redirects to index' do
        put :update, id: @address, address: FactoryGirl.attributes_for(:address, user_id: @user.id)
        response.should redirect_to addresses_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @address' do
        put :update, id: @address, address: FactoryGirl.attributes_for(:address, region: nil)
        assigns(:address).should eq(@address)
      end

      it 'does not change @address attrs' do
        prev_region = @address.region
        put :update, id: @address, address: FactoryGirl.attributes_for(:address, street_name:'Test', region: nil)
        @address.reload
        @address.street_name.should_not eq('Test')
        @address.region.should eq(prev_region)
      end

      it 're-renders the edit method' do
        put :update, id: @address, address: FactoryGirl.attributes_for(:address, region: nil)
        response.should render_template :edit
      end
    end
  end


  describe 'DELETE destroy' do
    before :each do
      @address = FactoryGirl.create(:address, user_id: @user.id)
    end

    it 'deletes the address' do
      expect {
        delete :destroy, id: @address
      }.to change(Address, :count).by(-1)
    end

    it 'redirects to addresses#index' do
      delete :destroy, id: @address
      response.should redirect_to addresses_url
    end
  end

end
