require 'spec_helper'

describe Admin::CategoriesController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of categoryes' do
      category = FactoryGirl.create(:category)
      get :index
      assigns(:categories).should eq([category])
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
      @category = FactoryGirl.create(:category)
      get :edit, id: @category
    end

    it 'assigns @category' do
      assigns(:category).should eq(@category)
    end

    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect { 
          post :create, category: FactoryGirl.attributes_for(:category)
        }.to change(Category,:count).by(1)
      end

      it 'redirects to index' do
        post :create, category: FactoryGirl.attributes_for(:category)
        response.should redirect_to admin_categories_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new category' do
        expect {
          post :create , category: FactoryGirl.attributes_for(:category, name: nil)
        }.to_not change(Category, :count)
      end

      it 're-renders the new method' do
        post :create, category: FactoryGirl.attributes_for(:category, name: nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do 
      @category = FactoryGirl.create(:category)
    end

    context 'with valid attributes' do
      it 'located the requested category' do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        assigns(:category).should eq(@category)
      end

      it "changes @category' attributes" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name:'Test')

        @category.reload
        @category.name.should eq('Test')
      end

      it 'redirects to index' do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        response.should redirect_to admin_categories_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @category' do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: nil)
        assigns(:category).should eq(@category)
      end

      it 'does not change @category attrs' do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: 111)
        @category.reload
        @category.name.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: nil)
        response.should render_template :edit
      end
    end
  end


  describe 'DELETE destroy' do
    before :each do
      @category = FactoryGirl.create(:category)
    end

    it 'deletes the category' do
      expect {
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to categoryes#index' do
      delete :destroy, id: @category
      response.should redirect_to admin_categories_url
    end
  end
end
