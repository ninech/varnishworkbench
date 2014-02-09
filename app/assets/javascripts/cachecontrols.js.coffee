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

  $('#form_timeout input').change (event) ->
    $.ajax({
        type: $('#form_timeout').attr('method'),
        url:  $('#form_timeout').attr('action'),
        data: $('#form_timeout').serialize(),
        dataType: 'jsonp',
    })

  $('.slider').each (ui) ->
    s = $(this).slider({
      min: parseInt($(this).closest('div.form-group').find('input').attr('data-min')),
      max: parseInt($(this).closest('div.form-group').find('input').attr('data-max')),
      step: 1,
      range: 'min',
      value: parseInt($(this).closest('div.form-group').find('input').val())
      slide: (event, ui) ->
        $(this).closest('div.form-group').find('input').val( ui.value )
        $(this).closest('div.form-group').find('.form-control-static').text( ui.value + 's' )
        $(this).closest('div.form-group').find('input').change()
    })
    $(this).closest('div.form-group').find('.form-control-static').show()
    $(this).closest('div.form-group').find('input').hide()
