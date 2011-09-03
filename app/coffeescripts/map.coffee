tripDateStart = $("input#trip_start").datetimepicker({maxDate: new Date(), dateFormat: 'dd/mm/yy'})


window.map = null
window.geocoder = null
window.marker = null
window.infowindow = null
window.directionsService = null
window.directionsDisplay = null

window.a = null

convert_lat_lng = (object) ->
  lat_lng = for key, value of object
    value
  if lat_lng.length == 2
    new google.maps.LatLng(lat_lng[0], lat_lng[1])
  else
    object

parse_route_request = (request) ->
  if request != ""
    request = JSON.parse(request)
    request.origin = convert_lat_lng(request.origin)
    request.destination = convert_lat_lng(request.destination)
    for waypoint in request.waypoints
      waypoint.location = convert_lat_lng(waypoint.location)
    request

window.init_map = (rendererOptions = { draggable: true }) ->
  if google?
    window.directionsService = new google.maps.DirectionsService()
    window.directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)
    options = {
      zoom: 1,
      center: new google.maps.LatLng(52.5234051, 13.411399899999992),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    window.map = new google.maps.Map($('#map')[0], options)
    window.directionsDisplay.setMap(window.map)
    # When dragging Route:
    google.maps.event.addListener directionsDisplay, 'directions_changed', () ->
      if directionsDisplay.directions.status == google.maps.DirectionsStatus.OK
        window.log =directionsDisplay.directions
        $("#trip_route").val JSON.stringify(directionsDisplay.directions.ag)
        $("#trip_distance").val directionsDisplay.directions.routes[0].legs[0].distance.value
        $("#trip_gmaps_duration").val directionsDisplay.directions.routes[0].legs[0].duration.value
        if $("#trip_distance_display")
          $("#trip_distance_display").html directionsDisplay.directions.routes[0].legs[0].distance.text
        $("#trip_form").submit()

window.set_new_route = (request = "") ->
  if google?
    if request == ""
      request = {
        origin: $("#trip_from").val()
        destination: $("#trip_to").val()
        waypoints: [],
        travelMode: google.maps.DirectionsTravelMode.DRIVING
      }
    else
      request = parse_route_request(request)
    window.directionsService.route request, (response, status) ->
      if status == google.maps.DirectionsStatus.OK
        window.directionsDisplay.setDirections response


window.calc_route = ->
  # Route the directions and pass the response to a
  # function to create markers for each step.


window.get_location = (location, suggest_field=null, destination=null) ->
  if google?
    if !geocoder?
      geocoder = new google.maps.Geocoder()

    geocoderRequest = { address: location }
    geocoder.geocode geocoderRequest, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        if results.length > 1
          ###
          #Suggestion fields deactivated for the moment
          max_results = 10
          if max_results >= results.length
            max_results = results.length
            $(suggest_field).html 'Suggestions:<br/>'
            for x in [0..max_results]
              if results[x]
                full_address = results[x].formatted_address
                link_to = "<a href='#' data-full-address='#{full_address}' class='set_map_search'>#{full_address}</a><br />"
                $(suggest_field).append link_to
            $(suggest_field).show()
          ###
        else
          #$(suggest_field).hide()
          location = results[0].geometry.location
          if destination == 'from'
            window.map.setCenter location
            window.map.setZoom 12
          $("input#trip_#{destination}_formatted_address").val results[0].formatted_address
          $("input#trip_#{destination}_lat").val location.lat()
          $("input#trip_#{destination}_lng").val location.lng()
          address_components = results[0].address_components
          if address_components.length > 0
            for x in [0..address_components.length-1]
              type = address_components[x].types[0]
              value = address_components[x].long_name
              switch type
                when 'locality'
                  set_field 'city', destination, value
                when 'country'
                  set_field 'country', destination, value
                when 'postal_code'
                  set_field 'zip', destination, value
                when 'route'
                  set_field 'street', destination, value
                when 'street_number'
                  set_field 'street_no', destination, value

  return

set_field = (type, destination, value) ->
  $("input#trip_#{destination}_#{type}").val value
  return
