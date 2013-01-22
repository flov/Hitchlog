window.Location = {
  autocomplete_attribute: (attribute) ->
    if $("input##{attribute}").length and google?
      geocoder = new google.maps.Geocoder()
      $("input##{attribute}").autocomplete
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
          $("##{attribute}_lat").val(ui.item.latitude)
          $("##{attribute}_lng").val(ui.item.longitude)
          geocoder.geocode {
              'latLng': latlng
            }, (results, status) ->
              for result in results
                if (result.types.some (word) -> ~"country".indexOf word)
                  $("##{attribute}_country").val( result.address_components[0].long_name )
                  $("##{attribute}_country_code").val(result.address_components[0].short_name)
                if (result.types.some (word) -> ~"locality".indexOf word)
                  $("##{attribute}_city").val( result.address_components[0].long_name )

          true
}
