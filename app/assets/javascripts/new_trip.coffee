$ ->
  #
  # Datepicker:
  #
  arrival_input = $('#trip_arrival').pickadate({
    clear: ''
    today: ''
    max: true
    onStart: ->
      date = new Date()
      date.setDate(date.getDate() - 5)
      this.set('select', date)
    onSet: ->
      updateDistanceOfTime()
  })
  window.$arrival_picker = arrival_input.pickadate('picker')

  departure_input = $('#trip_departure').pickadate({
    selectYears: 70
    selectMonths: true
    clear: ''
    today: ''
    max: true
    onStart: ->
      this.set('select', new Date())
    onSet: (event) ->
      $arrival_picker.set('min', new Date(event.select))
      $arrival_picker.set('select', event.select)
  })
  $departure_picker = departure_input.pickadate('picker')
  $('#trip_arrival_time').pickatime({
    clear: ''
    today: ''
    format: 'HH:i'
    interval: 15
    onStart: ->
      this.set('select', [18,0])
    onSet: (event) ->
      updateDistanceOfTime()
  })

  $('#trip_departure_time').pickatime({
    clear: ''
    format: 'HH:i'
    interval: 15
    onStart: ->
      this.set('select', [10,0])
    onSet: (event) ->
      updateDistanceOfTime()
  })

  if google?
    window.directionsDisplay = new google.maps.DirectionsRenderer({ draggable: true });
    window.directionsService = new google.maps.DirectionsService();

    mapOptions = {
      center: new google.maps.LatLng(52.5234051, 13.411399899999992),
      zoom: 1,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map($('#map-canvas')[0], mapOptions)
    directionsDisplay.setMap(map);

    #
    # When changing Route by dragging, construct new directions hash
    # with waypoints and store it in trip:
    #
    google.maps.event.addListener directionsDisplay, 'directions_changed', () ->
      if directionsDisplay.directions.status == google.maps.DirectionsStatus.OK
        # Route with waypoints
        $("#trip_route").val directions_hash(directionsDisplay)
        $("#trip_distance").val directionsDisplay.directions.routes[0].legs[0].distance.value
        # Google Maps duration
        $("#google_maps_duration").html google_timeago(directionsDisplay.directions.routes[0].legs[0].duration.value)
        $("#google_maps_duration").animate({opacity: 0.25}, 500, -> $("#google_maps_duration").animate({opacity:1}))
        # Display Distance
        $("#trip_distance_display").animate({opacity: 0.25}, 500, -> $("#trip_distance_display").animate({opacity:1}))
        $("#trip_distance_display").html directionsDisplay.directions.routes[0].legs[0].distance.text if $("#trip_distance_display")

    autocomplete_for( 'from', map )
    autocomplete_for( 'to', map )

    $("#trip_from_lat").observe_field 1, ->
      window.from = get_from_coordinates()
      if window.from && window.to
        route(window.from, window.to)

    $("#trip_to_lat").observe_field 1, ->
      window.to = get_to_coordinates()
      if window.from && window.to
        route(window.from, window.to)

from = ''
to = ''

set_inputs_for = (direction) ->
  if place.address_components.length > 0
    for x in [0..place.address_components.length-1]
      type = place.address_components[x].types[0]
      value = place.address_components[x].long_name
      switch type
        when 'locality'
          $("input#trip_#{direction}_city").val value
        when 'country'
          $("input#trip_#{direction}_country").val value
          $("input#trip_#{direction}_country_code").val place.address_components[x].short_name
        when 'postal_code'
          $("input#trip_#{direction}_postal_code").val value

autocomplete_for = (direction, map) ->
  input = $("input#trip_#{direction}")[0]

  autocompleteOptions = { types: ['geocode'] }
  autocomplete = new google.maps.places.Autocomplete(input, autocompleteOptions)
  autocomplete.bindTo('bounds', map)

  infowindow = new google.maps.InfoWindow()

  marker = new google.maps.Marker({ map: map })

  google.maps.event.addListener(autocomplete, 'place_changed', ->
    window.place = autocomplete.getPlace()
    if (!place.geometry)
      # Inform the user that the place was not found and return.
      $(".trip_#{direction} .controls").append('<span class="help-inline">Could not find location, please try again</span>')
      $(".trip_#{direction}").addClass('error')
      return

    # If the place has a geometry, then present it on a map.
    unless direction == 'to'
      if (place.geometry.viewport)
        map.fitBounds(place.geometry.viewport)
      else
        map.setCenter(place.geometry.location)
        map.setZoom(17)  # Why 17? Because it looks good.

    location = place.geometry.location

    $("input#trip_#{direction}_lat").val location.lat()
    $("input#trip_#{direction}_lng").val location.lng()
    $("input#trip_#{direction}_formatted_address").val place.formatted_address

    set_inputs_for( direction )
  )

get_from_coordinates = ->
  if !isNaN($("#trip_from_lat").val())
    from_lat = $("#trip_from_lat").val()
    from_lng = $("#trip_from_lng").val()
    return new google.maps.LatLng(from_lat, from_lng)

get_to_coordinates = ->
  if !isNaN($("#trip_to_lat").val())
    to_lat = $("#trip_to_lat").val()
    to_lng = $("#trip_to_lng").val()
    return new google.maps.LatLng(to_lat, to_lng)

route = (from, to) ->
  request =
    origin: from
    destination: to
    waypoints: []
    travelMode: google.maps.DirectionsTravelMode.DRIVING

  window.directionsService.route(request, (response, status) ->
    if (status == google.maps.DirectionsStatus.OK)
      window.directionsDisplay.setDirections(response);
  )

directions_hash = (directionsDisplay) ->
  waypoints = []
  leg = directionsDisplay.directions.routes[0].legs[0]
  directions =
    origin:                   new google.maps.LatLng(leg.start_location.lat(), leg.start_location.lng())
    destination:              new google.maps.LatLng(leg.end_location.lat(), leg.end_location.lng())
    travelMode:               google.maps.DirectionsTravelMode.DRIVING
    provideRouteAlternatives: false

  for waypoint, i in leg.via_waypoints
    waypoints[i] =
      location: new google.maps.LatLng(waypoint.lat(), waypoint.lng())
      stopover: false

  directions.waypoints = waypoints
  JSON.stringify(directions)

updateDistanceOfTime = ->
  if $("trip_arrival").val() != '' and $('trip_arrival_time').val() != '' and $('#trip_departure').val() != '' and $('#trip_departure_time').val() != ''
    start = new Date($("#trip_departure").val() + ' ' + $("#trip_departure_time").val())
    end = new Date($("#trip_arrival").val() + ' ' + $("#trip_arrival_time").val())
    $("#distance_of_time").html timeago(start, end)
    $("#distance_of_time").html timeago(start, end)
