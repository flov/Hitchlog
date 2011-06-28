$(document).ready ->
  init_map()
  $("#trip_from").observe_field 0.3, ->
    if this.value.length > 1
      get_location $("#trip_from").val(), $("#suggest_from"), "from"

  $('#suggest_from a').live 'click', ->
    $("#trip_from").val($(this).html())
    return false

  $("#trip_to").observe_field 0.3, ->
    if this.value.length > 1
      get_location $("#trip_to").val(), $("#suggest_to"), "to"

  $("#trip_to").change ->
    if this.value.length > 1
      setNewRoute()

  $('#suggest_to a').live 'click', ->
    $("#trip_to").val($(this).html())
    return false

  return
