/* DO NOT MODIFY. This file was compiled Wed, 29 Jun 2011 20:23:31 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/show_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map({
      draggable: false
    });
    return set_new_route($("#trip_route").val());
  });
}).call(this);
