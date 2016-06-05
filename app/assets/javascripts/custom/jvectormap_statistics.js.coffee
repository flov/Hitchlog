jQuery ->
  GENERAL_TOPICS     = [ "trips_count", "stories", "photos"]
  EXPERIENCE_TOPICS  = [ "bad_ratio", "good_ratio", "total_good", "neutral", "total_bad"]
  VEHICLE_TOPICS     = [ "car_ratio", "bus_ratio", "truck_ratio", "motorcycle_ratio", "plane_ratio", "boat_ratio"]
  TOPICS             = GENERAL_TOPICS.concat(EXPERIENCE_TOPICS).concat(VEHICLE_TOPICS)

  scale_colors_for_countries = (topic) ->
    if topic == "total_good" or topic == "good_ratio"
      ['#9CEC7A', '#4A952A']
    else if topic == "neutral"
      ['#FEFFA4c', '#FFAA00']
    else if topic == "total_bad" or topic == "bad_ratio"
      ['#FFDAA6', '#B20000']
    else
      ['#C8EEFF', '#0071A4']

  output_for_region = (topic, data, code) ->
    output = ""
    if topic in GENERAL_TOPICS
      output += "Number Of Trips: #{data["trips_count"][code]}<br/>" if data["trips_count"][code]
      if topic == 'stories'
        output += "Stories: #{data["stories"][code]} <i class='fa fa-font'></i><br/>" if data["stories"][code]
      else if topic == 'photos'
        output += "Pictures: #{data["photos"][code]} <i class='fa fa-camera'></i><br/>" if data["photos"][code]

    if topic in EXPERIENCE_TOPICS
      output += "Number Of Trips: #{data["trips_count"][code]}<br/>" if data["trips_count"][code]
      output += "#{data["very_good"][code]} very good experiences<br/>" if data["very_good"][code]
      output += "#{data["good"][code]} good experiences<br/>" if data["good"][code]
      output += "#{data["neutral"][code]} neutral experiences<br/>" if data["neutral"][code]
      output += "#{data["bad"][code]} bad experiences<br/>" if data["bad"][code]
      output += "#{data["very_bad"][code]} very bad experiences<br/>" if data["very_bad"][code]
      output += "#{data["bad_ratio"][code]}% <i class='fa fa-frown-o'></i><br/>" if data["bad_ratio"][code]
      output += "#{data["good_ratio"][code]}% <i class='fa fa-smile-o'></i><br/>" if data["good_ratio"][code]

    if topic in VEHICLE_TOPICS
      output += "#{data["car"][code]} / #{data["rides_with_vehicle"][code]} (#{data["car_ratio"][code]}%) with <i class='fa fa-car'></i><br/>" if data["car"][code]
      output += "#{data["bus"][code]} / #{data["rides_with_vehicle"][code]} (#{data["bus_ratio"][code]}%) with <i class='fa fa-bus'></i><br/>" if data["bus"][code]
      output += "#{data["truck"][code]} / #{data["rides_with_vehicle"][code]} (#{data["truck_ratio"][code]}%) with <i class='fa fa-truck'></i><br/>" if data["truck"][code]
      output += "#{data["motorcycle"][code]} / #{data["rides_with_vehicle"][code]} (#{data["motorcycle_ratio"][code]}%) with <i class='fa fa-motorcycle'></i><br/>" if data["motorcycle"][code]
      output += "#{data["plane"][code]} / #{data["rides_with_vehicle"][code]} (#{data["plane_ratio"][code]}%) with <i class='fa fa-plane'></i><br/>" if data["plane"][code]
      output += "#{data["boat"][code]} / #{data["rides_with_vehicle"][code]} (#{data["boat_ratio"][code]}%) with <i class='fa fa-boat'></i>" if data["boat"][code]
    return output

  search_url_for = (topic, code) ->
    switch topic
      when "trips_count"
        "trips?q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when 'photos'
        "trips?q%5Brides_photo_present%5D=1&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when 'stories'
        "trips?q%5Brides_story_present%5D=1&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when 'total_good', 'good_ratio'
        "trips?q%5Brides_experience_cont%5D=good&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when 'total_bad', 'bad_ratio'
        "trips?q%5Brides_experience_cont%5D=bad&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when 'neutral'
        "trips?q%5Brides_experience_eq%5D=neutral&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      when  "car_ratio", "bus_ratio", "truck_ratio", "motorcycle_ratio", "plane_ratio", "boat_ratio"
        vehicle = topic.slice(0, topic.indexOf("_")) # turning `car_ratio` into `car`
        "trips?q%5Brides_vehicle_eq%5D=#{vehicle}&q%5Bcountry_distances_country_code_eq%5D=#{code}"

      else
        ""

  $.ajax({
    url: "/data/country_map.json"
    dataType: "json"
    async: true
    success: (data) ->
      for topic in TOPICS
        $("##{topic}_country_map").vectorMap(
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
            if (data[current_topic][code])
              # show hand cursor if data avaialble
              document.body.style.cursor = 'pointer';
          onRegionOut: (e, code) ->
            # return to normal cursor
            document.body.style.cursor = 'default';
          series:
            regions: [{
              values: data[topic],
              attribute: 'fill',
              scale: scale_colors_for_countries(topic),
              normalizeFunction: 'polynomial'
            }]
          onRegionClick: (event, code) ->
            current_topic = $(this).parent().data("topic")
            window.location.href = search_url_for(current_topic, code)
          onRegionLabelShow: (event, label, code) ->
            current_topic = $(this).parent().data("topic")
            output = output_for_region(current_topic, data, code)

            label.html(
              "<b>#{label.html()}</b><br/>
               #{output}"
            )
          )
  })

  $( "#tabs" ).tabs()

  $("a.tabs_headline").click ->
    $(".country_map").resize()

  $('.country_tab a[data-toggle="tab"]').click ->
    # The Pills don't trigger .resize after click.
    # With setTimeout the resizing of the map works thought
    setTimeout( ->
      $(".country_map").resize()
     , 1)
