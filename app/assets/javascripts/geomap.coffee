$ ->
  $.ajax({
    url:"/hitchhikers/#{username}/geomap.json"
    dataType:"json"
    async: true
    success: (data) ->
      $('#world-map').vectorMap({
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

        series:
          regions: [{
            values: data.distances,
            attribute: 'fill',
            scale: ['#C8EEFF', '#0071A4'],
            normalizeFunction: 'polynomial'
          }]

        onRegionLabelShow: (event, label, code) ->
          if data.distances[code] != undefined
            label.html(
              "<b>#{label.html()}</b><br/>
               <b>Hitchhiked kms: </b>#{data.distances[code]}<br/>
               <b>Number of Trips: </b>#{data.trip_count[code]}"
            )
      })

  })

