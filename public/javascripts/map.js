/* DO NOT MODIFY. This file was compiled Mon, 04 Jul 2011 17:31:10 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/map.coffee
 */

(function() {
  var convert_lat_lng, parse_route_request, set_field, tripDateStart;
  tripDateStart = $("input#trip_start").datetimepicker({
    maxDate: new Date(),
    dateFormat: 'dd/mm/yy'
  });
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
        var key, value;
        if (directionsDisplay.directions.status === google.maps.DirectionsStatus.OK) {
          console.log(directionsDisplay);
          window.abc = (function() {
            var _ref, _results;
            _ref = directionsDisplay.directions;
            _results = [];
            for (key in _ref) {
              value = _ref[key];
              _results.push(key);
            }
            return _results;
          })();
          $("#trip_route").val(JSON.stringify(directionsDisplay.directions.cg));
          return $("#trip_form").submit();
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
                switch (type) {
                  case 'locality':
                    set_field('city', destination, value);
                    break;
                  case 'country':
                    set_field('country', destination, value);
                    break;
                  case 'postal_code':
                    set_field('zip', destination, value);
                    break;
                  case 'route':
                    set_field('street', destination, value);
                    break;
                  case 'street_number':
                    set_field('street_no', destination, value);
                }
                window.map.setZoom(12);
                window.marker.setPosition(location);
                _results.push(window.marker.setVisible(true));
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
