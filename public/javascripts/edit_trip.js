/* DO NOT MODIFY. This file was compiled Mon, 04 Jul 2011 15:34:08 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    set_new_route($("#trip_route").val());
    $("#accordion").accordion({
      collapsible: true
    });
    return $(".tabs").tabs();
  });
}).call(this);
