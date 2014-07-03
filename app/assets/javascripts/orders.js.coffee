# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#order_pay_type').val('Pay on Delivery')
  
  $('#order_pay_type').on 'change', ->
    credit_card_form = $('#order-credit-card')
    if $(this).val() == 'Credit card'
      credit_card_form.fadeToggle('slow')
    else
      credit_card_form.fadeToggle('slow')