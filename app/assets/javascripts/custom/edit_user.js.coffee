autocomplete_options = { types: ['geocode'] }
autocomplete = new google.maps.places.Autocomplete($("#user_location")[0], autocomplete_options)

$(".user_location .controls").append('<span class="help-inline"></span>')

google.maps.event.addListener(autocomplete, 'place_changed', ->
  place = autocomplete.getPlace()


  if (!place.geometry)
    # Inform the user that the place was not found and return.
    $(".user_location .controls span.help-inline").append(
      'Could not find location, please try again')
    $(".user_location").addClass('error')
    return

  else
    $("input#user_lat").val place.geometry.location.lat()
    $("input#user_lng").val place.geometry.location.lng()

    if place.address_components.length > 0
      for x in [0..place.address_components.length-1]
        types = place.address_components[x].types
        value = place.address_components[x].long_name
        if types.includes('locality')
          $("input#user_city").val value
          city = value
        else if types.includes('country')
          country = value
          country_code = place.address_components[x].short_name.toLowerCase()
          $("input#user_country").val country
          $("input#user_country_code").val country_code
)
