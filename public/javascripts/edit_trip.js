/* DO NOT MODIFY. This file was compiled Fri, 16 Mar 2012 03:16:26 GMT from
 * /Users/flov/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {

  $(document).ready(function() {
    init_map();
    set_new_route($("#trip_route").val());
    $("#accordion").accordion({
      collapsible: true,
      autoHeight: false
    });
    $(".tabs").tabs();
    $("#add_story").button().click(function() {
      return $("#tripstory").dialog({
        minWidth: 532
      });
    });
    $('#slider').nivoSlider({
      effect: 'fade',
      pauseTime: 8000,
      controlNav: false
    });
    if ($("#slider img").size() === 1) {
      $('#slider').data('nivoslider').stop();
      return $(".nivo-directionNav").remove();
    }
  });

}).call(this);
