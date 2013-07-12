window.timeago = (from_time, to_time = Date.now) ->
  from_time = from_time
  to_time   = to_time

  distance = Math.abs( (to_time - from_time))

  one_minute = 1000 * 60
  one_hour   = one_minute * 60
  one_day    = one_hour   * 24
  one_year   = one_day    * 356

  words = []
  while distance > 0
    if distance < one_hour
      words.push("#{Math.round(distance / one_minute)}m")
      distance = 0
    else if distance < one_day 
      words.push("#{Math.round(distance / one_hour)}h")
      distance = distance % one_hour
    else if distance < one_year# greater than a day
      words.push("#{Math.round(distance / one_day)}d")
      distance = distance % one_day
    else
      words.push("")
      distance = 0

  words = words.join(' ')
