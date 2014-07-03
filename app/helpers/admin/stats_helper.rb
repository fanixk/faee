module Admin::StatsHelper
  def orders_chart_day(start=3.weeks.ago)
    orders_by_day = Order.total_grouped_by_day(start)
    (start.to_date..Date.today).map do |date|
      {
        purchased_at: date,
        price: orders_by_day[date].try(:first).try(:day_total_price).to_f || 0,
        count: orders_by_day[date].try(:first).try(:cnt).to_i || 0 
      }
    end.to_json
  end

  def orders_chart_month(start=1.year.ago)
    orders_by_month = Order.total_grouped_by_month(start)
    start = start.to_date.beginning_of_month
    today = Date.today.beginning_of_month
    range = (start..today).select { |d| d.day == 1}
    range.map do |month|
      {
        purchased_at: month,
        price: orders_by_month[month].try(:first).try(:month_total_price).to_f || 0,
        count: orders_by_month[month].try(:first).try(:cnt).to_i || 0
      }
    end.to_json
  end
end
