/* DO NOT MODIFY. This file was compiled Fri, 09 Dec 2011 16:29:15 GMT from
 * /Users/flov/code/Hitchlog/app/coffeescripts/edit_trip.coffee
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
