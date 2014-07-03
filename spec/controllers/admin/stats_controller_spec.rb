require 'spec_helper'

describe Admin::StatsController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
  end

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index 
      response.should render_template :index
    end
  end
end
