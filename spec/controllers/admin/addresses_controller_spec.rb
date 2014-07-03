require 'spec_helper'

describe Admin::AddressesController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end


  describe 'GET #show' do
    it 'assigns the requested address to @address' do
      address = FactoryGirl.create(:address, user_id: @user.id)
      get :show, { user_id: @user.id, id: address.id }
      assigns(:address).should eq(address)
    end

    it 'renders the show view' do
      get :show, { user_id: @user.id, id: FactoryGirl.create(:address, user_id: @user.id) }
      response.should render_template :show
    end
  end
  
  describe 'GET #new' do
    it 'renders the new view' do
      get :new, { user_id: @user.id }
      response.should render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new address' do
        expect { 
          post :create, { user_id: @user.id, address: FactoryGirl.attributes_for(:address, user_id: @user.id) }
        }.to change(Address,:count).by(1)
      end

      it 'redirects to index' do
        post :create, { user_id: @user.id, address: FactoryGirl.attributes_for(:address, user_id: @user.id) }
        response.should redirect_to admin_user_path(@user)
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new address' do
        expect {
          post :create, { user_id: @user.id, address: FactoryGirl.attributes_for(:address, user_id: @user.id, region: nil) }
        }.to_not change(Address, :count)
      end

      it 're-renders the new method' do
        post :create, { user_id: @user.id, address: FactoryGirl.attributes_for(:address, user_id: @user.id, region: nil) }
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
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address) }
        assigns(:address).should eq(@address)
      end

      it "changes @address' attributes" do
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address, region: 'Test') }
        @address.reload
        @address.region.should eq('Test')
      end

      it 'redirects to index' do
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address, user_id: @user.id, region: 'test') }
        response.should redirect_to admin_user_path(@user)
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @address' do
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address, region: nil) }
        assigns(:address).should eq(@address)
      end

      it 'does not change @address attrs' do
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address, region: 111) }
        @address.reload
        @address.region.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, { user_id: @user.id, id: @address, address: FactoryGirl.attributes_for(:address, region: nil) }
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
        delete :destroy, { user_id: @user.id, id: @address }
      }.to change(Address, :count).by(-1)
    end

    it 'redirects to addresses#index' do
      delete :destroy, { user_id: @user.id, id: @address }
      response.should redirect_to admin_user_path(@user)
    end
  end
end
