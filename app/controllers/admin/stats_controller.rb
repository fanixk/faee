class Admin::StatsController < Admin::BaseController
  def index
    @total_visits = User.logins_by_period
    @total_users = User.signups_by_period
    @total_orders = Order.total_by_period('month')
    @total_sales = Order.sales_period_ago(30, 'days')
  end
end
