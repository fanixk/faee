require 'spec_helper'

describe Admin::SettingsController do
 include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of settings' do
      setting = FactoryGirl.create(:setting)
      get :index
      assigns(:settings).should eq([setting])
    end

    it 'renders the :index view' do
      get :index 
      response.should render_template :index
    end
  end

  describe 'GET #edit' do
    before :each do
      @setting = FactoryGirl.create(:setting)
      get :edit, id: @setting
    end

    it 'assigns @setting' do
      assigns(:setting).should eq(@setting)
    end

    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'PUT #update' do
    before :each do 
      @setting = FactoryGirl.create(:setting)
    end

    context 'with valid attributes' do
      it 'located the requested setting' do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting)
        assigns(:setting).should eq(@setting)
      end

      it "changes @setting' attributes" do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting, key:'Test')

        @setting.reload
        @setting.key.should eq('Test')
      end

      it 'redirects to index' do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting)
        response.should redirect_to admin_settings_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @setting' do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting, key: nil)
        assigns(:setting).should eq(@setting)
      end

      it 'does not change @setting attrs' do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting, key: 111)
        @setting.reload
        @setting.key.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, id: @setting, setting: FactoryGirl.attributes_for(:setting, key: nil)
        response.should render_template :edit
      end
    end
  end
 
end
