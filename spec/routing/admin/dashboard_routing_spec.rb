require "spec_helper"

describe Admin::DashboardController do
  describe "routing" do
    it "routes to #index" do
      get("/admin").should route_to("admin/dashboard#index")
    end
  end
end
