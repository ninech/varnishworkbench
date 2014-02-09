# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  $('#form_page').submit (event) ->
    event.preventDefault()
    $('#form_page_submit').prop('disabled', true)
    old_value = $('#form_page_submit').attr('value')
    $('#form_page_submit').attr('value',old_value+'...')

    $.ajax({
      type: $('#form_page').attr('method'),
      url:  $('#form_page').attr('action'),
      data: $("#form_page").serialize(),
      dataType: 'jsonp',
    }).done (json)->
      $('#form_page_submit').prop('disabled', false)
      $('#form_page_submit').attr('value',old_value)
