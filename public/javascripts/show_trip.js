/* DO NOT MODIFY. This file was compiled Mon, 06 Feb 2012 14:49:55 GMT from
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
      return $('#slider').data('nivoslider').stop();
    }
  });
}).call(this);
