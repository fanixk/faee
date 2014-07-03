require "spec_helper"

describe PagesController do
  describe "routing" do

    it "routes to #show" do
      get("slug").should route_to("pages#show", :slug => "slug")
    end

  end
end
