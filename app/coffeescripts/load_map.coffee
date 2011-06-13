$(document).ready ->
  #$('a.clear_address_fields').live 'click', (e) ->
    #e.preventDefault()
    #clear_address_fields()

  init_address_map()
  #getLocation $("#offer_map_search").val()

  $("#trip_from").observe_field 0.3, ->
    if this.value.length > 1
      get_location $("#trip_from").val()

  #$('#offer_map_search').focus()
  #$('#map_search').example 'Simple example'
  $('#suggest a').live 'click', ->
    $("#trip_from").val($(this).html())
    return false

  return
