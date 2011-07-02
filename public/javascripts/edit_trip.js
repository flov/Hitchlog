/* DO NOT MODIFY. This file was compiled Wed, 29 Jun 2011 23:08:32 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    set_new_route($("#trip_route").val());
    return $("#accordion").accordion();
  });
}).call(this);
