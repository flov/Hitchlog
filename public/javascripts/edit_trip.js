/* DO NOT MODIFY. This file was compiled Sat, 25 Feb 2012 04:38:12 GMT from
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
    $('#trip_story').markItUp(mySettings);
    $('#slider').nivoSlider({
      controlNav: false
    });
    if ($("#slider img").size() === 1) {
      $('#slider').data('nivoslider').stop();
      return $(".nivo-directionNav").remove();
    }
  });

}).call(this);
