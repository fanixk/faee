class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.open_orders.where('id > ?', params[:after].to_i).order(:purchased_at)
    @shipped_orders = Order.shipped_orders
    respond_to do |format|
      format.html
      format.js
    end
  end

end
