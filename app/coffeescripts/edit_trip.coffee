$(document).ready ->
  init_map()
  set_new_route($("#trip_route").val())
  $( "#accordion" ).accordion({collapsible: true})
  $( ".tabs" ).tabs()
  
