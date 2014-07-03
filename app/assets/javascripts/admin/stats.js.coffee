# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('#stats-page').length > 0
    json_data_day = $('#orders_charts_day').data('chart')
    json_data_month = $('#orders_charts_month').data('chart')
    
    Morris.Line
      element: 'orders_charts_day'
      data: json_data_day
      xkey: 'purchased_at'
      ykeys: ['price', 'count']
      labels: ['Total Sales', 'Total Orders']
      lineColors: ['#b9c45a', '#7a92a3']

    Morris.Line
      element: 'orders_charts_month'
      data: json_data_month
      xkey: 'purchased_at'
      ykeys: ['price', 'count']
      labels: ['Total Sales', 'Total Orders']
      lineColors: ['#b9c45a', '#7a92a3']
