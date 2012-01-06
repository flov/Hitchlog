/* DO NOT MODIFY. This file was compiled Thu, 29 Dec 2011 16:33:23 GMT from
 * /Users/flov/code/Hitchlog/app/coffeescripts/new_trip.coffee
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
    $("input#trip_start").datetimepicker({
      maxDate: new Date(),
      dateFormat: 'dd/mm/yy'
    });
    return $("input#trip_end").datetimepicker({
      maxDate: new Date(),
      dateFormat: 'dd/mm/yy'
    });
  });
}).call(this);
