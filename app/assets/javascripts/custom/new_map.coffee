class window.HitchMap
  constructor: (@type) ->
    mapOptions = {
      center: new google.maps.LatLng(52.5234051, 13.411399899999992),
      zoom: 1,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    @directions_display = new google.maps.DirectionsRenderer({draggable: true})
    @directions_service = new google.maps.DirectionsService()
    @map = new google.maps.Map($('#map')[0], mapOptions)
    @directions_display.setMap(@map)

    #
    # When changing Route by dragging, construct new directions hash
    # with waypoints and store it in trip:
    #
    google.maps.event.addListener @directions_display, 'directions_changed', () =>
      if @directions_display.directions.status == google.maps.DirectionsStatus.OK
        # update route and distance inputs
        @construct_country_distance(@directions_display.getDirections())
        @set_routing_inputs()

    this.autocomplete("#{@type}_from")
    this.autocomplete("#{@type}_to")


  autocomplete: (input_id) ->
    input = $("input##{input_id}")[0]

    autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
    autocomplete.bindTo('bounds', @map)

    google.maps.event.addListener(autocomplete, 'place_changed', =>
      place = autocomplete.getPlace()

      if (!place.geometry)
        # Inform the user that the place was not found and return.
        $(".#{input_id} .controls").append('<span class="help-inline">Could not find location, please try again</span>')
        $(".#{input_id}").addClass('error')
        return

      else
        # set input values
        #
        if place.address_components.length > 0
          for x in [0..place.address_components.length-1]
            type = place.address_components[x].types[0]
            value = place.address_components[x].long_name
            switch type
              when 'locality'
                $("input##{input_id}_city").val value
              when 'country'
                $("input##{input_id}_country").val value
                $("input##{input_id}_country_code").val place.address_components[x].short_name
              when 'postal_code'
                $("input##{input_id}_postal_code").val value

        $("input##{input_id}_lat").val place.geometry.location.lat()
        $("input##{input_id}_lng").val place.geometry.location.lng()
        $("input##{input_id}_formatted_address").val place.formatted_address

        @set_routing_inputs()

        if input_id.indexOf('from') > 0
          @from = place.geometry.location
        else if input_id.indexOf('to') > 0
          @to = place.geometry.location
        if @from and @to
          # show route if from and to are defined
          this.route(@from, @to)
        else
          # show destination on map
          @map.setCenter(place.geometry.location)
          @map.setZoom(9)
    )

  route: (from, to) ->
    request =
      origin: from
      destination: to
      waypoints: []
      travelMode: google.maps.DirectionsTravelMode.DRIVING

    @directions_service.route(request, (response, status) =>
      if (status == google.maps.DirectionsStatus.OK)
        @construct_country_distance(response)
        @directions_display.setDirections(response)
    )

  construct_country_distance: (data) =>
    distance = 0
    from_country = $("input#trip_from_country").val()
    countries = [[from_country, distance]]
    steps = data.routes[0].legs[0].steps
    for step, i in steps
      distance += step['distance']['value']
      if step.instructions.includes("Entering")
        # construct html parser since instructions will return:
        # e.g. Continue onto <b>A12</b><div style="font-size:0.9em">Entering Poland</div>
        parser = document.createElement("html")
        parser.innerHTML = step.instructions
        divs = parser.getElementsByTagName('div')
        country = divs[divs.length-1].textContent.replace("Entering ", "")
        countries[countries.length-1][1] = distance
        countries.push([country, 0])

        distance = 0
      if (i == steps.length-1)
        countries[countries.length-1][1] = distance

    $("input#trip_countries").val(@parse_array_to_string(countries))

  parse_array_to_string: (array) =>
    output = "["
    for country, i in array
      if i != array.length-1
        output += "[\"#{country[0]}\",#{country[1]}],"
      else
        output += "[\"#{country[0]}\",#{country[1]}]"
    output += "]"
    return output

  build_directions_hash: =>
    waypoints = []
    leg = @directions_display.directions.routes[0].legs[0]
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

  set_routing_inputs: ->
    if @directions_display.directions
      $("#trip_route").val @build_directions_hash
      $("#trip_distance").val @directions_display.directions.routes[0].legs[0].distance.value

      # Display Distance and Google Maps duration
      $("#google_maps_duration").html google_timeago(@directions_display.directions.routes[0].legs[0].duration.value)
      $("#google_maps_duration").animate({opacity: 0.25}, 500, -> $("#google_maps_duration").animate({opacity:1}))
      $("#trip_gmaps_duration").val @directions_display.directions.routes[0].legs[0].duration.value

      $("#trip_distance_display").html @directions_display.directions.routes[0].legs[0].distance.text if $("#trip_distance_display")
      $("#trip_distance_display").animate({opacity: 0.25}, 500, -> $("#trip_distance_display").animate({opacity:1}))

