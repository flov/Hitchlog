/* DO NOT MODIFY. This file was compiled Mon, 11 Jul 2011 10:54:52 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/new_trip.coffee
 */

(function() {
  $(document).ready(function() {
    init_map();
    $("#trip_from").observe_field(0.3, function() {
      if (this.value.length > 1) {
        return get_location($("#trip_from").val(), $("#suggest_from"), "from");
      }
    });
    $("#trip_to").observe_field(0.3, function() {
      if (this.value.length > 1) {
        return get_location($("#trip_to").val(), $("#suggest_to"), "to");
      }
    });
    $("#trip_to").change(function() {
      if (this.value.length > 1) {
        set_new_route();
        return $("#km_display").show();
      }
    });
    $('#suggest_from a').live('click', function() {
      $("#trip_from").val($(this).html());
      return false;
    });
    $('#suggest_to a').live('click', function() {
      $("#trip_to").val($(this).html());
      return false;
    });
  });
}).call(this);
