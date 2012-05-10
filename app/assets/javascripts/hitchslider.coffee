
$(".hitchslider_directionNav").bind("ajax:beforeSend", ->
  # show Loader image
  $("#hitchslider_loader").fadeIn('slow')
  # show trip information at bottom
  $("#hitchslider_caption").fadeOut('slow')
  # show icons of trip ( countries, experience, ...)
  $("#hitchslider_information").fadeOut('slow')

).on("ajax:complete", (event, data, status) ->
  # hide Loader image
  $("#hitchslider_loader").fadeOut('slow')
  response = $.parseJSON(data.responseText)
  # change trip information
  $("#hitchslider_caption").html("<p>#{response.caption}</p>")
  # change icons of trip
  $("#hitchslider_information").html(response.images_for_ride)
  # show new image
  $("#hitchslider_image img").fadeOut 'slow', ->
    $("#hitchslider_image").append("<a href='#{response.trip_path}'><img src='#{response.photo_url}' /></a>")

  # fade in information
  $("#hitchslider_caption").fadeIn('slow')
  # fade in icons
  $("#hitchslider_information").fadeIn('slow')

  # Set new route
  if response.route
    Hitchmap.set_new_route(response.route)
  else
    Hitchmap.set_new_route(null, response.from, response.to)
).on("ajax:error", ->
  console.log("ajax:error")
)

