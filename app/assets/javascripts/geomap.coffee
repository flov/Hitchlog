google.load('visualization', '1', {'packages': ['geomap']})
google.setOnLoadCallback(drawMap)

window.drawMap = ->
  jsondata = [['country', 'no of trips']]
  console.log jsondata
  jsondata.push(JSON.parse(
    $.ajax(
        url: '/hitchhikers/flov/geomap.json',
        dataType: 'json',
        async: false
    ).responseText
  ))
  console.log jsondata

  # Create our data table out of JSON data loaded from server.
  data = new google.visualization.DataTable(jsonData);

  geomap = new google.visualization.GeoMap($('#chart_div')[0])
  geomap.draw(data, {'dataMode': 'regions'})

