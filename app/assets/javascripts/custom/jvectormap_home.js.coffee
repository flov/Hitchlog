jQuery ->
  output_for_region = (data, code) ->
    output = ""
    output += "Number Of Trips: #{data["trips_count"][code]}<br/>" if data["trips_count"][code]
    output += "Stories: #{data["stories"][code]} <i class='fa fa-font'></i><br/>" if data["stories"][code]
    output += "Pictures: #{data["photos"][code]} <i class='fa fa-camera'></i><br/>" if data["photos"][code]
    output

  $.ajax({
    url: "/data/trips_count.json"
    dataType: "json"
    async: true
    success: (data) ->
      $("#worldmap_home").vectorMap(
        map: 'world_mill_en'
        backgroundColor: '#FFFFFF'
        regionStyle:
          initial: {
            fill: '#CCCCCC',
            "fill-opacity": 1,
            stroke: 'none',
            "stroke-width": 0,
            "stroke-opacity": 1
          },
          hover: {
            "fill-opacity": 0.8
          }
        onRegionOver: (e, code) ->
          current_topic = $(this).parent().data("topic")
          if (data["trips_count"][code])
            # show hand cursor if data avaialble
            document.body.style.cursor = 'pointer';
        onRegionOut: (e, code) ->
          # return to normal cursor
          document.body.style.cursor = 'default';
        series:
          regions: [{
            values: data["trips_count"],
            attribute: 'fill',
            scale: ['#C8EEFF', '#0071A4'],
            normalizeFunction: 'polynomial'
          }]
        onRegionClick: (event, code) ->
          window.location.href = "trips?q%5Bcountry_distances_country_code_eq%5D=#{code}"
        onRegionLabelShow: (event, label, code) ->
          output = output_for_region(data, code)

          label.html(
            "<b>#{label.html()}</b><br/>
             #{output}"
          )
        )
  })

