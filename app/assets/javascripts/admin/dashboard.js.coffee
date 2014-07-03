# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@OrderPoller =
  poll: ->
    setTimeout @request, 5000

  request: ->
    # $.ajax $('#orders').data('url'), 
    #   dataType: 'script'
    #   data:
    #     after: $('.order').last().data('id')
    $.get $("#orders").data("url"),
      after: $("#open-orders .order").last().data("id"), 
      ((data) ->), 
      "script"

  addOrders: (orders) ->
    if orders.length > 0
      $('#orders').append($(orders).hide())
      $('#show_orders').show()
      $('#zero-pending-orders').hide()
    else
      $('#zero-pending-orders').show()
    @poll()

  showOrders: (e) ->
    e.preventDefault()
    $('.order').show()
    $('#show_orders').hide()

jQuery ->
  if $('#orders').length > 0
    OrderPoller.poll()
    $('#show_orders a').click OrderPoller.showOrders