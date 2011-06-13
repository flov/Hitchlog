/* DO NOT MODIFY. This file was compiled Sun, 12 Jun 2011 19:39:52 GMT from
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
  window.init_address_map = function() {
    var options;
    if (typeof google !== "undefined" && google !== null) {
      options = {
        zoom: 1,
        center: new google.maps.LatLng(52.5234051, 13.411399899999992),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      window.map = new google.maps.Map($('#map')[0], options);
    }
  };
  set_field = function(type, value) {
    $("input#trip_from_" + type).val(value);
  };
  window.get_location = function(location) {
    var geocoder, geocoderRequest;
    if (typeof google !== "undefined" && google !== null) {
      if (!(typeof geocoder !== "undefined" && geocoder !== null)) {
        geocoder = new google.maps.Geocoder();
      }
      geocoderRequest = {
        address: location
      };
      geocoder.geocode(geocoderRequest, function(results, status) {
        var address_components, full_address, link_to, max_results, type, value, x, _ref;
        if (status === google.maps.GeocoderStatus.OK) {
          if (results.length > 1) {
            console.log(results);
            max_results = 10;
            if (max_results >= results.length) {
              max_results = results.length;
              $("#suggest").html('Suggestions:<br/>');
              for (x = 0; 0 <= max_results ? x <= max_results : x >= max_results; 0 <= max_results ? x++ : x--) {
                if (results[x]) {
                  full_address = results[x].formatted_address;
                  link_to = "<a href='#' data-full-address='" + full_address + "' class='set_map_search'>" + full_address + "</a><br />";
                  $("#suggest").append(link_to);
                }
              }
              return $("#suggest").show();
            }
          } else {
            $("#suggest").hide();
            location = results[0].geometry.location;
            window.map.setCenter(location);
            $("input#trip_from_lat").val(location.lat());
            $("input#trip_from_lng").val(location.lng());
            address_components = results[0].address_components;
            if (address_components.length > 0) {
              for (x = 0, _ref = address_components.length - 1; 0 <= _ref ? x <= _ref : x >= _ref; 0 <= _ref ? x++ : x--) {
                type = address_components[x].types[0];
                value = address_components[x].long_name;
                switch (type) {
                  case 'locality':
                    set_field('city', value);
                    break;
                  case 'country':
                    set_field('country', value);
                    set_field('country_code_iso', address_components[x].short_name);
                    break;
                  case 'postal_code':
                    set_field('zip', value);
                    break;
                  case 'route':
                    set_field('street', value);
                    break;
                  case 'street_number':
                    set_field('street_no', value);
                }
              }
              if (!(window.marker != null)) {
                window.marker = new google.maps.Marker({
                  map: window.map
                });
              }
              window.map.setZoom(12);
              window.marker.setPosition(location);
              window.marker.setVisible(true);
              return $('#address_selection').show();
            }
          }
        }
      });
    }
  };
}).call(this);
