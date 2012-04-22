window.Hitchmap = {
  init_map: (rendererOptions = { draggable: true}, mapdiv = "#map") ->
    if google?
      window.directionsService = new google.maps.DirectionsService()
      window.directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)

      options = {
        zoom: 1,
        center: new google.maps.LatLng(52.5234051, 13.411399899999992),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }

      map = new google.maps.Map($(mapdiv)[0], options)
      directionsDisplay.setMap(map)

  set_new_route: (directionsRequest, from = '', to = '') ->
    if google?
      if directionsRequest == "" and from != '' and to != ''
        directionsRequest =
          origin: from
          destination: to
          waypoints: []
          travelMode: google.maps.DirectionsTravelMode.DRIVING
      else
        directionsRequest = parse_route_request(directionsRequest)

      window.directionsService.route directionsRequest, (response, status) ->
        if status == google.maps.DirectionsStatus.OK
          window.directionsDisplay.setDirections response
}


convert_lat_lng = (object) ->
  lat_lng = for key, value of object
    value
  if lat_lng.length == 2
    new google.maps.LatLng(lat_lng[0], lat_lng[1])
  else
    object

parse_route_request = (route) ->
  if route != ""
    route = JSON.parse(route)
    route.origin = convert_lat_lng(route.origin)
    route.destination = convert_lat_lng(route.destination)
    for waypoint in route.waypoints
      waypoint.location = convert_lat_lng(waypoint.location)
    route

