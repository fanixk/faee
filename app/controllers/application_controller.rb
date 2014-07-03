class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

  protected
    def set_locale(locale)
      if I18n.available_locales.to_s.include?(locale)
        I18n.locale = locale
      else
        flash.now[:notice] = "#{locale} translation not available"
        logger.error flash.now[:notice]
      end
    end
  
end
