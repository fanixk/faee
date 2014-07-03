require 'spec_helper'

describe OmniauthCallbacksController do
  include Devise::TestHelpers

  it { should respond_to(:all) }
  it { should respond_to(:setup) }

  describe 'omniauth' do
    context 'when facebook user doesnt exist in the system' do
      context 'with all user info available' do
        before :each do
          stub_omniauth(false)
          get :facebook
        end
        it 'should create new facebook user' do
          User.where(provider: 'facebook').first.email.should == 'abc@abc.com'
        end

        it { should be_user_signed_in }
        it { response.should redirect_to root_url }
      end

      context 'with missing user info' do
        before :each do
          stub_omniauth(true)
          get :facebook
        end

        it 'should not create new user' do
          User.where(provider: 'facebook', email: 'abc@abc.com').count.should == 0
        end
        it { should_not be_user_signed_in }
        it { response.should redirect_to new_user_registration_path }
      end

    end

    context "when facebook uid already exists" do
      before(:each) do
        stub_omniauth(false)

        user = FactoryGirl.create(:user, :via_facebook, uid: '9999')
        get :facebook
      end
            
      it "user logins" do
        should be_user_signed_in
        response.should redirect_to redirect_to root_url
      end
    end
  end
end

def stub_omniauth(invalid)
  request.env['devise.mapping'] = Devise.mappings[:user]
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '9999',
    :info => {
      :nickname => 'test',
      :email => 'abc@abc.com',
      :first_name => 'Mpampis',
      :last_name => 'Sougias'
    }
  })
  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  request.env['omniauth.auth'][:info].delete(:last_name) if invalid
  request.env['omniauth.auth']
end