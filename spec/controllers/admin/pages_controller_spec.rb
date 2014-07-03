require 'spec_helper'

describe Admin::PagesController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of pages' do
      page = FactoryGirl.create(:page)
      get :index
      assigns(:pages).should eq([page])
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
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new page' do
        expect { 
          post :create, page: FactoryGirl.attributes_for(:page)
        }.to change(Page,:count).by(1)
      end

      it 'redirects to index' do
        post :create, page: FactoryGirl.attributes_for(:page)
        response.should redirect_to admin_pages_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new page' do
        expect {
          post :create , page: FactoryGirl.attributes_for(:page, slug: '/test')
        }.to_not change(Page, :count)
      end

      it 're-renders the new method' do
        post :create, page: FactoryGirl.attributes_for(:page, slug: '/test')
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do 
      @page = FactoryGirl.create(:page)
    end

    context 'with valid attributes' do
      it 'located the requested page' do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page)
        assigns(:page).should eq(@page)
      end

      it "changes @page' attributes" do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page, name:'Test')

        @page.reload
        @page.name.should eq('Test')
      end

      it 'redirects to index' do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page)
        response.should redirect_to admin_pages_url
        flash[:notice].should_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @page' do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page, name: nil)
        assigns(:page).should eq(@page)
      end

      it 'does not change @page attrs' do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page, name: 111)
        @page.reload
        @page.name.should_not eq(111)
      end

      it 're-renders the edit method' do
        put :update, id: @page, page: FactoryGirl.attributes_for(:page, name: nil)
        response.should render_template :edit
      end
    end
  end


  describe 'DELETE destroy' do
    before :each do
      @page = FactoryGirl.create(:page)
    end

    context 'page with no children' do
      it 'deletes the page' do
        expect {
          delete :destroy, id: @page
        }.to change(Page, :count).by(-1)
      end

      it 'redirects to pagees#index' do
        delete :destroy, id: @page
        response.should redirect_to admin_pages_url
      end
    end

    context 'page with children' do
      it 'doesnt delete page with children' do
        child = FactoryGirl.create(:page, parent_id: @page)
        expect {
          delete :destroy, id: @page
        }.to_not change(Page,:count)
      end

      it 'redirects to pagees#index' do
        delete :destroy, id: @page
        response.should redirect_to admin_pages_url
      end
    end
  end

  describe 'POST #sort' do
    before do
      @page1 = FactoryGirl.create(:page)
      @page2 = FactoryGirl.create(:page)
      @page3 = FactoryGirl.create(:page)

    end

    it 'renders nothing' do
      post :sort, page: [@page2.id,@page1.id,@page3.id]

      response.body.should be_blank
    end
  end
end
