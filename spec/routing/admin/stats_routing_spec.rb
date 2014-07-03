require "spec_helper"

describe Admin::StatsController do
  describe "routing" do
    it "routes to #index" do
      get("/admin/stats").should route_to("admin/stats#index")
    end
  end
end
