/* DO NOT MODIFY. This file was compiled Thu, 29 Dec 2011 12:22:11 GMT from
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
    $("#add_story").button().click(function() {
      return $("#tripstory").dialog({
        minWidth: 532
      });
    });
    return $('#trip_story').markItUp(mySettings);
  });
}).call(this);
