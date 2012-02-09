/* DO NOT MODIFY. This file was compiled Thu, 09 Feb 2012 16:29:45 GMT from
 * /Users/flov/code/Hitchlog/app/coffeescripts/show_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map({
      draggable: false
    });
    set_new_route($("#trip_route").val());
    $('#slider').nivoSlider({
      controlNav: false
    });
    if ($("#slider img").size() === 1) {
      $('#slider').data('nivoslider').stop();
      return $(".nivo-directionNav").remove();
    }
  });
}).call(this);
