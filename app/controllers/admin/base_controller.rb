class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin
  layout 'admin'

  private
    def authenticate_admin
      if signed_in?
        redirect_to(root_url, :alert => 'You are not authorized!') unless current_user.admin?
      else
        redirect_to(root_url, :alert => 'You are not authorized!')
      end
    end
end