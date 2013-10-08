$ ->
  arrival_input = $('#trip_arrival').pickadate({
    clear: ''
    today: ''
    max: true
    onSet: ->
      updateDistanceOfTime()
  })
  window.$arrival_picker = arrival_input.pickadate('picker')

  departure_input = $('#trip_departure').pickadate({
    selectYears: 70
    selectMonths: true
    clear: ''
    today: ''
    max: true
    onStart: ->
      date = new Date()
      date.setDate(date.getDate() - 5)
      this.set('select', date)
    onSet: (event) ->
      $arrival_picker.set('min', new Date(event.select))
      $arrival_picker.set('select', event.select)
  })

  $('#trip_arrival_time').pickatime({
    clear: ''
    today: ''
    format: 'HH:i'
    interval: 15
    onStart: ->
      this.set('select', [18,0])
    onSet: (event) ->
      updateDistanceOfTime()
  })
  $('#trip_departure_time').pickatime({
    clear: ''
    format: 'HH:i'
    interval: 15
    onStart: ->
      this.set('select', [10,0])
    onSet: (event) ->
      updateDistanceOfTime()
  })

  window.map = new Map('trip')

updateDistanceOfTime = ->
  if $("trip_arrival").val() != '' and $('trip_arrival_time').val() != '' and $('#trip_departure').val() != '' and $('#trip_departure_time').val() != ''
    start = new Date($("#trip_departure").val() + ' ' + $("#trip_departure_time").val())
    end = new Date($("#trip_arrival").val() + ' ' + $("#trip_arrival_time").val())
    $("#distance_of_time").html timeago(start, end)
    $("#distance_of_time").html timeago(start, end)
