/* DO NOT MODIFY. This file was compiled Thu, 29 Dec 2011 16:33:23 GMT from
 * /Users/flov/code/Hitchlog/app/coffeescripts/map.coffee
 */

(function() {
  var convert_lat_lng, directions_hash, parse_route_request, set_field;
  window.map = null;
  window.geocoder = null;
  window.marker = null;
  window.infowindow = null;
  window.directionsService = null;
  window.directionsDisplay = null;
  window.a = null;
  convert_lat_lng = function(object) {
    var key, lat_lng, value;
    lat_lng = (function() {
      var _results;
      _results = [];
      for (key in object) {
        value = object[key];
        _results.push(value);
      }
      return _results;
    })();
    if (lat_lng.length === 2) {
      return new google.maps.LatLng(lat_lng[0], lat_lng[1]);
    } else {
      return object;
    }
  };
  parse_route_request = function(request) {
    var waypoint, _i, _len, _ref;
    if (request !== "") {
      request = JSON.parse(request);
      request.origin = convert_lat_lng(request.origin);
      request.destination = convert_lat_lng(request.destination);
      _ref = request.waypoints;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        waypoint = _ref[_i];
        waypoint.location = convert_lat_lng(waypoint.location);
      }
      return request;
    }
  };
  window.init_map = function(rendererOptions) {
    var options;
    if (rendererOptions == null) {
      rendererOptions = {
        draggable: true
      };
    }
    if (typeof google !== "undefined" && google !== null) {
      window.directionsService = new google.maps.DirectionsService();
      window.directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
      options = {
        zoom: 1,
        center: new google.maps.LatLng(52.5234051, 13.411399899999992),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      window.map = new google.maps.Map($('#map')[0], options);
      window.directionsDisplay.setMap(window.map);
      return google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
        if (directionsDisplay.directions.status === google.maps.DirectionsStatus.OK) {
          window.log = directionsDisplay.directions;
          $("#trip_route").val(directions_hash(directionsDisplay));
          $("#trip_distance").val(directionsDisplay.directions.routes[0].legs[0].distance.value);
          $("#trip_gmaps_duration").val(directionsDisplay.directions.routes[0].legs[0].duration.value);
          if ($("#trip_distance_display")) {
            $("#trip_distance_display").html(directionsDisplay.directions.routes[0].legs[0].distance.text);
          }
          return $("form#trip_form").submit();
        }
      });
    }
  };
  window.set_new_route = function(request) {
    if (request == null) {
      request = "";
    }
    if (typeof google !== "undefined" && google !== null) {
      if (request === "") {
        request = {
          origin: $("#trip_from").val(),
          destination: $("#trip_to").val(),
          waypoints: [],
          travelMode: google.maps.DirectionsTravelMode.DRIVING
        };
      } else {
        request = parse_route_request(request);
      }
      return window.directionsService.route(request, function(response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
          return window.directionsDisplay.setDirections(response);
        }
      });
    }
  };
  directions_hash = function(directionsDisplay) {
    var directions, i, leg, waypoint, waypoints, _len, _ref;
    waypoints = [];
    leg = directionsDisplay.directions.routes[0].legs[0];
    directions = {
      origin: new google.maps.LatLng(leg.start_location.lat(), leg.start_location.lng()),
      destination: new google.maps.LatLng(leg.end_location.lat(), leg.end_location.lng()),
      travelMode: google.maps.DirectionsTravelMode.DRIVING,
      provideRouteAlternatives: false
    };
    _ref = leg.via_waypoints;
    for (i = 0, _len = _ref.length; i < _len; i++) {
      waypoint = _ref[i];
      waypoints[i] = {
        location: new google.maps.LatLng(waypoint.lat(), waypoint.lng()),
        stopover: false
      };
    }
    directions.waypoints = waypoints;
    return JSON.stringify(directions);
  };
  window.get_location = function(location, suggest_field, destination) {
    var geocoder, geocoderRequest;
    if (suggest_field == null) {
      suggest_field = null;
    }
    if (destination == null) {
      destination = null;
    }
    if (typeof google !== "undefined" && google !== null) {
      if (!(typeof geocoder !== "undefined" && geocoder !== null)) {
        geocoder = new google.maps.Geocoder();
      }
      geocoderRequest = {
        address: location
      };
      geocoder.geocode(geocoderRequest, function(results, status) {
        var address_components, type, value, x, _ref, _results;
        if (status === google.maps.GeocoderStatus.OK) {
          if (results.length > 1) {
            /*
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
                      */
          } else {
            location = results[0].geometry.location;
            if (destination === 'from') {
              window.map.setCenter(location);
              window.map.setZoom(12);
            }
            $("input#trip_" + destination + "_formatted_address").val(results[0].formatted_address);
            $("input#trip_" + destination + "_lat").val(location.lat());
            $("input#trip_" + destination + "_lng").val(location.lng());
            address_components = results[0].address_components;
            if (address_components.length > 0) {
              _results = [];
              for (x = 0, _ref = address_components.length - 1; 0 <= _ref ? x <= _ref : x >= _ref; 0 <= _ref ? x++ : x--) {
                type = address_components[x].types[0];
                value = address_components[x].long_name;
                _results.push((function() {
                  switch (type) {
                    case 'locality':
                      return set_field('city', destination, value);
                    case 'country':
                      return set_field('country', destination, value);
                    case 'postal_code':
                      return set_field('zip', destination, value);
                    case 'route':
                      return set_field('street', destination, value);
                    case 'street_number':
                      return set_field('street_no', destination, value);
                  }
                })());
              }
              return _results;
            }
          }
        }
      });
    }
  };
  set_field = function(type, destination, value) {
    $("input#trip_" + destination + "_" + type).val(value);
  };
}).call(this);
