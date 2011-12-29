$(document).ready ->
  init_map()
  set_new_route($("#trip_route").val())

  # Accordion for rides:
  $( "#accordion" ).accordion({collapsible: true,autoHeight: false})
  # Tabs for ride:
  $( ".tabs" ).tabs()

  # Add Story:
  $( "#add_story" )
    .button()
    .click( -> $( "#tripstory" ).dialog({minWidth: 532 }))
  $('#trip_story').markItUp(mySettings)

