window.Hitchmap = {
  init_map: (rendererOptions = { draggable: true}, map_div = "#map") ->
    console.log rendererOptions
    if google?
      directionsService = new google.maps.DirectionsService()
      directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)

      options = {
        zoom: 1,
        center: new google.maps.LatLng(52.5234051, 13.411399899999992),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }

      map = new google.maps.Map($("#map")[0], options)
      window.directionsDisplay.setMap(map)
}
