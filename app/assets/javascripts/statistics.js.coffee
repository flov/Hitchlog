jQuery ->
  monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"]

  new Morris.Line(
    element: 'hitchhiked_kms_per_month'
    data: $('#hitchhiked_kms_per_month').data('trips')
    xkey: 'created_at'
    ykeys: ['trips_count', 'sign_ups_count']
    labels: ['Number of Trips', 'Sign Ups']
    xLabels: 'month'
    xLabelFormat: (x) ->
      return monthNames[new Date(x).getMonth()]
    dateFormat: (x) ->
      return "#{monthNames[new Date(x).getMonth()]} #{new Date(x).getFullYear()}"
  )

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
    element: 'experiences_donut',
    data: $("#experiences_donut").data('experiences')
    colors: ['#3C8D2F', 'green', '#F5F205', '#AA3C39', '#801916' ]
    formatter: (y, data) ->
      return "#{y}%"
  ).on('click', (i, row) ->
    window.location.href = "http://#{window.location.hostname}/trips?q%5Brides_experience_eq%5D=#{row.label}"
  )
