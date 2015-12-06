initMap = ->
  from  = $("#trip_from").val()
  to    = $("#trip_to").val()
  route = JSON.parse($("#trip_route").val())

  map = new (google.maps.Map)(document.getElementById('map'),
    center: new google.maps.LatLng(52.5234051, 13.411399899999992)
    scrollwheel: false
    zoom: 2)
  directionsDisplay = new (google.maps.DirectionsRenderer)(map: map)
  # Set destination, origin and travel mode.
  if route.waypoints.length > 0
    request = route
  else
    request =
      origin: from
      destination: to
      travelMode: google.maps.TravelMode.DRIVING
  # Pass the directions request to the directions service.
  directionsService = new (google.maps.DirectionsService)
  directionsService.route request, (response, status) ->
    if status == google.maps.DirectionsStatus.OK
      # Display the route on the map.
      directionsDisplay.setDirections response
    return
  return

initMap()
