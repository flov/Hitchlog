/* DO NOT MODIFY. This file was compiled Wed, 29 Jun 2011 20:25:20 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/trips_new.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    $("#trip_from").observe_field(0.3, function() {
      if (this.value.length > 1) {
        return get_location($("#trip_from").val(), $("#suggest_from"), "from");
      }
    });
    $('#suggest_from a').live('click', function() {
      $("#trip_from").val($(this).html());
      return false;
    });
    $("#trip_to").observe_field(0.3, function() {
      if (this.value.length > 1) {
        return get_location($("#trip_to").val(), $("#suggest_to"), "to");
      }
    });
    $("#trip_to").change(function() {
      if (this.value.length > 1) {
        return set_new_route();
      }
    });
    $('#suggest_to a').live('click', function() {
      $("#trip_to").val($(this).html());
      return false;
    });
  });
}).call(this);
