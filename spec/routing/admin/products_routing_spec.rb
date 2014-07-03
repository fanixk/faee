require "spec_helper"

describe Admin::ProductsController do
  describe "routing" do

    it 'routes to #index' do
      get('/admin/products').should route_to('admin/products#index')
    end

    it "routes to #new" do
      get("/admin/products/new").should route_to("admin/products#new")
    end

    it "routes to #edit" do
      get("/admin/products/1/edit").should route_to("admin/products#edit", id: '1')
    end

    it "routes to #create" do
      post("/admin/products").should route_to("admin/products#create")
    end

    it "routes to #update" do
      put("/admin/products/1/").should route_to("admin/products#update", id: '1')
    end

    it "routes to #destroy" do
      delete("/admin/products/1").should route_to("admin/products#destroy", id: '1')
    end

    it 'routes to #index via search' do
      get('admin/products/search').should route_to('admin/products#index')
      post('admin/products/search').should route_to('admin/products#index')
    end
  end
end
