# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  $('#cachecontrol-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

  $('#form_cachecontrol input').change (event) ->
    $.ajax({
      type: $(this).parents('form').attr('method'),
      url:  $(this).parents('form').attr('action'),
      data: $(this).parents('form').serialize(),
      dataType: 'jsonp',
    })

  $('.slider').each (ui) ->
    $(this).slider({
      min: 1,
      max: 30,
      step: 1,
      range: 'min',
      value: parseInt($(this).closest('div.form-group').find('input').val())
      slide: (event, ui) ->
        $(this).closest('div.form-group').find('input').val( ui.value + 's' )
    })
    $(this).closest('div.form-group').find('input').attr('disabled', true)

