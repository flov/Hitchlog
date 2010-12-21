$(function(){

  // Drop Down menu when clicking on trip links:
  var trip_id
  $("a.trip").click(function(e){
    trip_id = $(this).attr("rel")
    if ($("#trip_" + trip_id).is(":visible")) {
      $("#trip_" + trip_id).slideUp()
    } else {
      $("#trip_" + trip_id).slideDown()      
    };
    e.preventDefault()
  })
  
})