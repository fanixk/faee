require "spec_helper"

describe Admin::SettingsController do
  describe "routing" do

    it 'routes to #index' do
      get('/admin/settings').should route_to('admin/settings#index')
    end

    it "routes to #new" do
      get("/admin/settings/new").should route_to("admin/settings#new")
    end

    it "routes to #edit" do
      get("/admin/settings/1/edit").should route_to("admin/settings#edit", id: '1')
    end

    it "routes to #create" do
      post("/admin/settings").should route_to("admin/settings#create")
    end

    it "routes to #update" do
      put("/admin/settings/1/").should route_to("admin/settings#update", id: '1')
    end

    it "routes to #destroy" do
      delete("/admin/settings/1").should route_to("admin/settings#destroy", id: '1')
    end

  end
end
