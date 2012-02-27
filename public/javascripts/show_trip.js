/* DO NOT MODIFY. This file was compiled Fri, 16 Mar 2012 03:10:48 GMT from
 * /Users/flov/code/hitchlog/app/coffeescripts/show_trip.coffee
 */

(function() {

  $(document).ready(function() {
    init_map({
      draggable: false
    });
    set_new_route($("#trip_route").val());
    $('#slider').nivoSlider({
      controlNav: false,
      effect: 'fade',
      pauseTime: 8000
    });
    if ($("#slider img").size() === 1) {
      $('#slider').data('nivoslider').stop();
      return $(".nivo-directionNav").remove();
    }
  });

}).call(this);
