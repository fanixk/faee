require "spec_helper"

describe AddressesController do
  describe "routing" do
    it "routes to #index" do
      get("/user/addresses").should route_to("addresses#index")
    end

    it "routes to #new" do
      get("/user/addresses/new").should route_to("addresses#new")
    end


    it "routes to #edit" do
      get("/user/addresses/1/edit").should route_to("addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user/addresses").should route_to("addresses#create")
    end

    it "routes to #update" do
      put("/user/addresses/1").should route_to("addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user/addresses/1").should route_to("addresses#destroy", :id => "1")
    end
  end
end
