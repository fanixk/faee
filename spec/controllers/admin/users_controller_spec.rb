require 'spec_helper'

describe Admin::UsersController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of user' do
      user = FactoryGirl.create(:user)
      get :index
      assigns(:users).should eq([user])
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
      @user1 = FactoryGirl.create(:user)
      get :edit, id: @user1
    end

    it 'assigns @user1' do
      assigns(:user).should eq(@user1)
    end

    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      user = FactoryGirl.create(:user)
      get :show, id: user
      assigns(:user).should eq(user)
    end

    it 'renders the show view' do
      get :show, id: FactoryGirl.create(:user)
      response.should render_template :show
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect { 
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User,:count).by(1)
      end

      it 'redirects to index' do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to admin_users_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user' do
        expect {
          post :create , user: FactoryGirl.attributes_for(:user, last_name: nil)
        }.to_not change(User, :count)
      end

      it 're-renders the new method' do
        post :create, user: FactoryGirl.attributes_for(:user, last_name: nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do 
      @user = FactoryGirl.create(:user)
    end

    context 'with valid attributes' do
      it 'located the requested user' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        assigns(:user).should eq(@user)
      end

      it "changes @user' attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, last_name:'Test')

        @user.reload
        @user.last_name.should eq('Test')
      end

      it 'redirects to index' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to admin_users_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @user' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, last_name: nil)
        assigns(:user).should eq(@user)
      end

      it 'does not change @user attrs' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, last_name: 111)
        @user.reload
        @user.last_name.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, last_name: nil)
        response.should render_template :edit
      end
    end
  end


  describe 'DELETE destroy' do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it 'deletes the user' do
      expect {
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end

    it 'redirects to useres#index' do
      delete :destroy, id: @user
      response.should redirect_to admin_users_url
    end
  end
end
