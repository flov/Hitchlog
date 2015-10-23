class window.Location
  constructor: (input_id) ->
    input = $("input##{input_id}")[0]

    autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })

    google.maps.event.addListener(autocomplete, 'place_changed', =>
      place = autocomplete.getPlace()

      if (!place.geometry)
        # Inform the user that the place was not found and return.
        $("#{ input_id } .controls").append('<span class="help-inline">Could not find location, please try again</span>')
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
    )
