class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def setup
    if params[:provider] == 'twitter'
      request.env['omniauth.strategy'].options[:consumer_key] = Setting.twitter_api_key
      request.env['omniauth.strategy'].options[:consumer_secret] = Setting.twitter_api_secret
    elsif params[:provider] == 'facebook'
      request.env['omniauth.strategy'].options[:client_id] = Setting.fb_api_key
      request.env['omniauth.strategy'].options[:client_secret] = Setting.fb_api_secret
    else
      raise 'Unknown Omniauth Provider'
    end
    render :text => "Setup complete.", :status => 404
  end

  def all
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
end
