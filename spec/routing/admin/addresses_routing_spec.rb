require "spec_helper"

describe Admin::AddressesController do
  describe "routing" do

    it "routes to #new" do
      get("/admin/users/1/addresses/new").should route_to("admin/addresses#new", user_id: '1')
    end

    it "routes to #edit" do
      get("/admin/users/1/addresses/1/edit").should route_to("admin/addresses#edit", user_id: '1', id: '1')
    end

    it "routes to #create" do
      post("/admin/users/1/addresses").should route_to("admin/addresses#create", user_id: '1')
    end

    it "routes to #update" do
      put("/admin/users/1/addresses/1").should route_to("admin/addresses#update", user_id: '1', id: '1')
    end

    it "routes to #destroy" do
      delete("/admin/users/1/addresses/1").should route_to("admin/addresses#destroy", user_id: '1', id: '1')
    end
  end
end
