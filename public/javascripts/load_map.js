/* DO NOT MODIFY. This file was compiled Sun, 12 Jun 2011 19:14:00 GMT from
 * /Users/florianvallen/code/hitchlog/app/coffeescripts/load_map.coffee
 */

(function() {
  $(document).ready(function() {
    init_address_map();
    $("#trip_from").observe_field(0.3, function() {
      if (this.value.length > 1) {
        return get_location($("#trip_from").val());
      }
    });
    $('#suggest a').live('click', function() {
      $("#trip_from").val($(this).html());
      return false;
    });
  });
}).call(this);
