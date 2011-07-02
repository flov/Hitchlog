/* DO NOT MODIFY. This file was compiled Sat, 02 Jul 2011 12:02:39 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    set_new_route($("#trip_route").val());
    $("#accordion").accordion();
    return $(".tabs").tabs();
  });
}).call(this);
