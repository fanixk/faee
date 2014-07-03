require "spec_helper"

describe OrdersController do
  describe "routing" do
    it "routes to #index" do
      get('orders').should route_to('orders#index')
    end

    it "routes to #new" do
      get("/orders/new").should route_to("orders#new")
    end

    it "routes to #create" do
      post('/orders').should route_to('orders#create')
    end
  end
end
