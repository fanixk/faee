class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.preparing_orders.includes(:address, :line_items).order('purchased_at desc')
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_index_path, :notice => I18n.t('.Your cart is empty')
      return
    end

    # logger.error('ID --------------------- ' + current_user.id.to_s)
    @order = Order.new
    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @order }
    end
  end

  def create
    @order = Order.new(params[:order].merge(:user_id => current_user.id))
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        if @order.purchase
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          format.html { redirect_to store_index_path, :notice => I18n.t('.Thank you for your order') }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { redirect_to store_index_path, alert: "Purchase couldn't be completed." }
        end
      else
        @cart = current_cart
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
end
