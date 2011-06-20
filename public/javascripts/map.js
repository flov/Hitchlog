/* DO NOT MODIFY. This file was compiled Mon, 20 Jun 2011 15:39:27 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/map.coffee
 */

(function() {
  var set_field, tripDateStart;
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
  window.init_address_map = function() {
    var options;
    if (typeof google !== "undefined" && google !== null) {
      window.directionsService = new google.maps.DirectionsService();
      window.directionsDisplay = new google.maps.DirectionsRenderer();
      options = {
        zoom: 1,
        center: new google.maps.LatLng(52.5234051, 13.411399899999992),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      window.map = new google.maps.Map($('#map')[0], options);
      window.directionsDisplay.setMap(window.map);
    }
  };
  set_field = function(type, destination, value) {
    $("input#trip_" + destination + "_" + type).val(value);
  };
  window.setNewRoute = function(from, to) {
    var request;
    request = {
      origin: from,
      destination: to,
      travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    return window.directionsService.route(request, function(response, status) {
      if (status === google.maps.DirectionsStatus.OK) {
        return window.directionsDisplay.setDirections(response);
      }
    });
  };
  window.get_location = function(location, suggest_field, destination) {
    var geocoder, geocoderRequest;
    if (typeof google !== "undefined" && google !== null) {
      if (!(typeof geocoder !== "undefined" && geocoder !== null)) {
        geocoder = new google.maps.Geocoder();
      }
      geocoderRequest = {
        address: location
      };
      geocoder.geocode(geocoderRequest, function(results, status) {
        var address_components, type, value, x, _ref;
        if (status === google.maps.GeocoderStatus.OK) {
          if (results.length > 1) {
            /*
                      #Suggestion fields deactivated for the moment
                      console.log results
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
              }
              if (!(window.marker != null) && destination === 'from') {
                window.marker = new google.maps.Marker({
                  map: window.map
                });
                window.map.setZoom(12);
                window.marker.setPosition(location);
                return window.marker.setVisible(true);
              }
            }
          }
        }
      });
    }
  };
}).call(this);
