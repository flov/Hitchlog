$(function(){
  // GOOGLE MAPS:
  // I initiate the Map and associate it with the #map_canvas div
  // Because it is necessary to define a start location i just chose
  // my home location and set the zoom level to 1.
  
  var directionsDisplay = new google.maps.DirectionsRenderer()
  var directionsService = new google.maps.DirectionsService()
  var map;
  var startlocation = new google.maps.LatLng(33.431441,61.523438)
  var myOptions = {
    zoom: 1,
    mapTypeId: google.maps.MapTypeId.HYBRID,
    center: startlocation
  }

  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
  directionsDisplay.setMap(map)

  // I execute this function whenever the routes need to be set again
  function SetNewRoute(from, to) {
    var request = {
        origin: from, 
        destination: to,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    } 
    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response)
      }
    })
  }
  
  var from = $('#hitchhike-from').html()
  var to   = $('#hitchhike-to').html()
  SetNewRoute(from, to)

  $('#hitchhike-detail-close').click(function(){
    $(this).parent().animate({bottom: '-=52' })
  })
	})
