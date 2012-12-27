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
          if status == google.maps.GeocoderStatus.OK
            if results[1]
              $("#user_city").val(
                results[1].address_components[1].long_name)
              $("#user_country").val(
                results[1].address_components[3].long_name)
              $("#user_country_code").val(
                results[1].address_components[3].short_name)
          else
            alert("Geocoder failed due to: " + status)

      true


#supplierMap = $('#supplier-map')
#if supplierMap.length > 0

  #$("#location_address, #company_address").bind "autocompleteselect", (event, ui) ->
    #$('#location_address_input .inline-hints, #company_address_input .inline-hints').remove()

    #latlng = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);

    #map = new google.maps.Map supplierMap[0],
      #mapTypeControl: false
      #overviewMapControl: false
      #disableDefaultUI: true
      #zoom: 11
      #center: latlng
      #mapTypeId: google.maps.MapTypeId.ROADMAP

    #marker = new google.maps.Marker
      #position: latlng
      #map: map

    #circle = new google.maps.Circle
      #strokeColor: "#FFFFFF"
      #strokeOpacity: 0.9
      #strokeWeight: 2
      #fillColor: "#000000"
      #fillOpacity: 0.1
      #map: map
      #center: latlng
      #radius: 0

    #supplierMap.animate
      #"progress": 1
    #,
      #easing: "linear",
      #duration: 2000,
      #step: (a, obj) ->
        #circle.setRadius(obj.state * 30000)

    #supplierMap.closest('.supplier-map').addClass('loaded')

