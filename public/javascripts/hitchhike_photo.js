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




  // Keep track of properties of the photo details.
	var objMouseOutTimeout = null
	var objIsAnimatingSitePhotoDetails = { Show: false, Hide: false }
	var objSitePhotoRequest = null
	
	// I show the site photo details (if necesssary).
	function ShowSitePhotoDetails(){
		// We only want to animate the Show if we are:
		// 1. Not currently showing the photo details.
		// 2. Currently hiding the photo details.
		if (!objIsAnimatingSitePhotoDetails.Show ||	objIsAnimatingSitePhotoDetails.Hide	)	{
			// Check to see if we need to stop any animation.
			if (objIsAnimatingSitePhotoDetails.Hide){ $( "#hitchhike-photo-details" ).stop()	}
			
			// Flag the animations.
			objIsAnimatingSitePhotoDetails.Show = true
			objIsAnimatingSitePhotoDetails.Hide = false
			
			// Stop any existing animation and show the details.
			$( "#hitchhike-photo-details" ).animate({	bottom: '0px'	},
				{
					duration: 150,
					
					// When complete, flag all animations as being done.
					complete: function(){
						objIsAnimatingSitePhotoDetails.Show = false
						objIsAnimatingSitePhotoDetails.Hide = false
					}
				}
				)
		}
	}
	
	
	// I hide the site photo details.
	function HideSitePhotoDetails(){
		// When mousing down, set the animation flags.
		objIsAnimatingSitePhotoDetails.Show = false
		objIsAnimatingSitePhotoDetails.Hide = true
		// Slide details down.
		$( "#hitchhike-photo-details" ).animate(
		  { bottom: '-52px'	},{
				duration: 100,
				// When complete, flag all animations as being done.
				complete: function(){
					objIsAnimatingSitePhotoDetails.Show = false
					objIsAnimatingSitePhotoDetails.Hide = false
				}
     }).fadeTo( 1, 1 )}

	// I handle the mouse over functionality for both the photo and 
	// the photo details as they are going to act in the same fashion.
	function SitePhotoMouseOverHandler(){
		// Clear any mouse out time out so that our details don't disaapear.
		clearTimeout( objMouseOutTimeout )			
		// Show the photo details.
		ShowSitePhotoDetails()
	}

	// I handle the mouse out functionality for both the photo and 
	// the photo details as they are going to act in the same fashion.
	function SitePhotoMouseOutHandler(){
		// Because of the way that events happen, set a timeout for this mouse
		// out action. This will give the mouse-over action a change to 
		// cancel the bubble.
		objMouseOutTimeout = setTimeout(
	  	function(){
				HideSitePhotoDetails()
			},100)
		}
  
	// I handle the mouse over of the photo area.
	$( [] ).add( $( "#hitchhike-photo" ) ).add( $( "#hitchhike-photo-details" ) ).mouseover(
		function(){
			SitePhotoMouseOverHandler()
			return( false )
		})
	
	// I handle the mouse out of the photo area.
	$( [] ).add( $( "#hitchhike-photo" ) ).add( $( "#hitchhike-photo-details" ) ).mouseout(
		function(){
			SitePhotoMouseOutHandler()
			return( false )
		})
	})
