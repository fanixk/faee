require 'spec_helper'

describe "Pages" do

  before do
    @page = FactoryGirl.create(:page)
  end

  describe "GET /slug" do
    context "with existant page" do
      it "should respond with page" do
        slug = @page.slug
        get "/#{slug}"
        response.status.should be(200)
      end
    end
  end
end
