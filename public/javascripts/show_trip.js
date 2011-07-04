/* DO NOT MODIFY. This file was compiled Mon, 04 Jul 2011 17:04:28 GMT from
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
