class RegistrationsController < Devise::RegistrationsController
  before_filter :find_cart, only: [:edit, :new]

  private
    def find_cart
      @cart = current_cart
    end
end
