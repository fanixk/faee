require "spec_helper"

describe LineItemsController do
  describe "routing" do
    it "routes to #create" do
      post("/line_items").should route_to("line_items#create")
    end

    it "routes to #destroy" do
      delete("/line_items/1").should route_to("line_items#destroy", :id => "1")
    end

  end
end
