jQuery ->
  new Morris.Donut(
    element: 'company_donut',
    data: $("#company_donut").data('company-for-trips')
    formatter: (y, data) ->
      return "#{y}%"
  )

  new Morris.Donut(
    element: 'gender_donut',
    data: $("#gender_donut").data('hitchhikers-by-gender')
    colors: ['#7596C4', '#FF8DA1']
    formatter: (y, data) ->
      return "#{y}%"
  )

  new Morris.Donut(
    element: 'vehicles_donut',
    data: $("#vehicles_donut").data('vehicles')
  )

  new Morris.Donut(
    element: 'experiences_donut',
    data: $("#experiences_donut").data('experiences')
    colors: ['#3C8D2F', 'green', '#F5F205', '#AA3C39', '#801916' ]
    formatter: (y, data) ->
      return "#{y}%"
  ).on('click', (i, row) ->
    window.location.href = "http://#{window.location.hostname}/trips?q%5Brides_experience_eq%5D=#{row.label}"
  )

  new Morris.Bar(
    element: 'top_10_hitchhikers',
    data: $('#top_10_hitchhikers').data('hitchhikers'),
    xkey: 'username',
    ykeys: ['total_distance'],
    labels: ['Hitchhiked kms']
    barColors: (row, series, type) ->
      if (row.label.slice(-1) == 'm')
        return '#0B62A4'
      else
        return '#FF8DA1'
  ).on('click', (i, row) ->
    username = row.username.toLowerCase().substring(0, row.username.length - 2)
    window.location.href = "http://#{window.location.hostname}/hitchhikers/#{username}"
  )

  new Morris.Donut(
    element: 'waiting_time_donut',
    data: $("#waiting_time_donut").data('waiting-time')
    formatter: (y, data) ->
      return "#{y}%"
  )
