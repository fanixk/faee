class Admin::OrdersController < Admin::BaseController
  before_filter :find_order, only: [:ship, :cancel, :complete, :resume]

  def index
    @orders = Order.includes(:user,:address).order('purchased_at desc')
    @search = @orders.search(params[:q])
    @orders = @search.result.paginate(params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def ship
    @order.ship
    respond_to do |format|
      format.html { redirect_to admin_orders_path, :notice => I18n.t('.Order shipped!') }
      format.js
    end
  end

  def complete
    @order.complete
    respond_to do |format|
      format.html { redirect_to admin_orders_path, :notice => I18n.t('.Order completed!') }
      format.js
    end
  end

  def cancel
    @order.cancel
    respond_to do |format|
      format.html { redirect_to admin_orders_path, :notice => I18n.t('.Order canceled!') }
      format.js
    end
  end

  def resume
    @order.resume
    respond_to do |format|
      format.html { redirect_to admin_orders_path, :notice => I18n.t('.Order resumed!') }
      format.js
    end
  end 

  private
    def find_order
      @order = Order.find(params[:order_id])
    end
end
