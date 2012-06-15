slide_duration = 200

window.Hitchslider = {
  init: (route, from, to) ->
    Hitchmap.init_map({draggable: false}, "#hitchslider_map")
    Hitchmap.set_new_route(route, from, to)
    if $('.hitchslider_story').html().match(/\S/g) == null 
      $('#hitchslider_map').css('width', '450px')


  hide_objects: ->
    # show Loader image
    $("#hitchslider_loader").fadeIn('slow')
    $("#hitchslider_caption").animate({
      bottom: '-100px'
    }, slide_duration)
    # show icons of trip ( countries, experience, ...)
    $("#hitchslider_information").animate({ left: '-300px' }, slide_duration)

  load_objects: (response) ->
    # hide Loader image
    $("#hitchslider_loader").fadeOut('slow')
    # change trip information
    $("#hitchslider_caption").html("<p>#{response.caption}</p>")
    # change icons of trip
    $("#hitchslider_information").html(response.images_for_ride)
    $("#hitchslider_image img").fadeOut 'slow', ->
      $("#hitchslider_image").append("<a href='#{response.trip_path}'><img src='#{response.photo_url}' /></a>")

  show_objects: ->
    # fade in information
    $("#hitchslider_caption").animate({bottom: '0'}, slide_duration)
    # fade in icons
    $("#hitchslider_information").animate({ left: 0 }, slide_duration)

  set_new_route: (response) ->
    # Set new route
    if response.route
      Hitchmap.set_new_route(response.route)
    else
      Hitchmap.set_new_route(null, response.from, response.to)

  hide_story: ->
    $("#hitchslider_map").animate({width: '450px'})
    $(".hitchslider_story").html('')

  show_story: (response) ->
    $(".hitchslider_story").html(response.title)
    $(".hitchslider_story").append(response.story)
    $("#hitchslider_map").animate({width: '215px'})

  set_prev_and_next_buttons: (response) ->
    $("#hitchslider_nextNav").attr('href', response.next_link)
    $("#hitchslider_prevNav").attr('href', response.prev_link)
}

$(".hitchslider_directionNav").bind("ajax:beforeSend", ->
  Hitchslider.hide_objects()
).on("ajax:complete", (event, data, status) ->
  response = $.parseJSON(data.responseText)
  Hitchslider.load_objects(response)
  Hitchslider.show_objects()
  Hitchslider.set_new_route(response)
  Hitchslider.set_prev_and_next_buttons(response)
  if response.story != ''
    Hitchslider.show_story(response)
  else
    Hitchslider.hide_story()

).on("ajax:error", ->
  console.log("ajax:error")
)

