module AccurateDistanceOfTimeInWordsHelper
  def accurate_distance_of_time_in_words(seconds)
    seconds = seconds.to_f
    array = []

    while(seconds > 0)
      if seconds >= 1.day
        days, seconds = seconds.divmod(1.day)
        array << I18n.t('datetime.distance_in_words.x_days', count: days)
      elsif seconds >= 1.hour
        hours, seconds = seconds.divmod(1.hour)
        array << I18n.t('datetime.distance_in_words.x_hours', count: hours)
      elsif seconds >= 1.minute
        minutes, seconds = seconds.divmod(1.minute)
        array << I18n.t('datetime.distance_in_words.x_minutes', count: minutes)
      else
        seconds = 0
      end
    end

    array.to_sentence
  end

  alias_method :accurate_time, :accurate_distance_of_time_in_words
end
