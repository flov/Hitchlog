/* DO NOT MODIFY. This file was compiled Wed, 29 Jun 2011 23:04:18 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/edit_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    return setNewRoute($("#trip_route").val());
  });
}).call(this);
