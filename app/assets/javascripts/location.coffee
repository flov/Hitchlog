if $("input#user_location").length and google?
  geocoder = new google.maps.Geocoder()
  $("input#user_location").autocomplete
    minLength: 1
    source: (request, response) ->
      address = request.term

      geocoder.geocode {
          'address': address
        }, (results, status) ->
          response $.map results, (item) ->
            label:  item.formatted_address,
            value: item.formatted_address,
            latitude: item.geometry.location.lat(),
            longitude: item.geometry.location.lng()

    select: (event, ui) ->
      latlng = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
      $("#user_lat").val(ui.item.latitude)
      $("#user_lng").val(ui.item.longitude)
      geocoder.geocode {
          'latLng': latlng
        }, (results, status) ->
          for result in results
            console.log result.types
            console.log result
            if (result.types.some (word) -> ~"country".indexOf word)
              $("#user_country").val( result.address_components[0].long_name )
              $("#user_country_code").val(result.address_components[0].short_name)
            if (result.types.some (word) -> ~"locality".indexOf word)
              $("#user_city").val( result.address_components[0].long_name )

      true
