require 'spec_helper'

describe PagesController do

  describe "get#show" do
    context "with published/existing page" do 
      it "responds with success" do
        page = Page.create!({name: 'page1', content:'content1', is_published: true})
        get :show, slug: page.slug
        response.should be_success
      end
    end

    context "with non existing page" do
      it "renders 404" do
        begin
          get :show, slug: 'thegame'
        rescue
          response.should render_template(:file => "#{Rails.root}/public/404.html")
        end
      end
    end

    context "with non published page" do
      it "renders 404" do
        page = Page.create!({name: 'page1', content:'content1', is_published: false})
        begin
          get :show, slug: page.slug
        rescue
          response.should render_template(:file => "#{Rails.root}/public/404.html" )
        end
      end
    end

  end

end
