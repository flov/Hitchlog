$(document).ready ->
  init_map({draggable: false})
  set_new_route($("#trip_route").val())
