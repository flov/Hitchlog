/* DO NOT MODIFY. This file was compiled Wed, 28 Dec 2011 07:19:05 GMT from
 * /Users/flov/code/Hitchlog/app/coffeescripts/edit_trip.coffee
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
    $('#trip_story').markItUp(mySettings);
    return $("#add_story").button().click(function() {
      return $("#tripstory").dialog({
        minWidth: 532
      });
    });
  });
}).call(this);
