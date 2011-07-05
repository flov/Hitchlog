/* DO NOT MODIFY. This file was compiled Tue, 05 Jul 2011 12:25:03 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    set_new_route($("#trip_route").val());
    $("#accordion").accordion({
      collapsible: true,
      autoHeight: false
    });
    return $(".tabs").tabs();
  });
}).call(this);
