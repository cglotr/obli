# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".new-payment").click (e) ->
    amount = e.target.textContent
    $(".payment-amount-field").val(amount.match(/\d+\.\d+/))
