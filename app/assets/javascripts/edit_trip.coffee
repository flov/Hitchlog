$(document).ready ->
  init_map()
  set_new_route($("#trip_route").val())
  
  # Tabs for ride:
  $( ".tabs" ).tabs()
  # Accordion for rides:
  $( "#accordion" ).accordion({collapsible: true})
