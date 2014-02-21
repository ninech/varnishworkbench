# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

frontend_reload = () ->
  timeout = parseInt($('#inputReload').val())
  if timeout >= 0
      setTimeout(frontend_reload, timeout * 1000)
  else
      return 0
  $('.loading').show()
  $.ajax({
      url:   '/page',
      cache: false,
      dataType: 'json',
  }).done (json, status, xhr) ->
    $('.loading').hide()
    $('#frontend_title').text(json.title)
    $('#frontend_body').text(json.text)
    cache = xhr.getResponseHeader('X-Varnish-Cache');
    if (cache == 'HIT')
      $('#hdr_cache').html('<i class="fa fa-check-square text-success"></i> Hit');
    else if (cache == 'MISS')
      $('#hdr_cache').html('<i class="fa fa-times-circle text-danger"></i> Miss');
    else
      $('#hdr_cache').html('<i class="fa fa-exclamation-triangle text-warning"></i> Unknown')
    $('#hdr_cacheable').html(xhr.getResponseHeader('X-Varnish-Cacheable'));
    $('#hdr_ttl').html(xhr.getResponseHeader('X-Varnish-Ttl'));
    $('#hdr_age').html(xhr.getResponseHeader('Age'));
    $('#hdr_vary').html(xhr.getResponseHeader('Vary'));
    $('#hdr_date').html(xhr.getResponseHeader('Date'));
    $('#hdr_expires').html(xhr.getResponseHeader('Expires'));
    $('#hdr_cachecontrol').html(xhr.getResponseHeader('Cache-Control'));

$(document).ready () ->
  frontend_reload()
