module ApplicationHelper
  def driving_time_difference(hours)
    if hours < 0
      t('helper.faster_than_gmaps')
    else
      t('helper.slower_than_gmaps')
    end
  end

  def human_hours(hours)
    hours = (hours.to_f * 100).round.to_f / 100
    if hours != 0
      if hours < 0
        minutes = ((1-(hours % 1)) * 60).round
      else
        minutes = ((hours % 1) * 60).round
      end
      if minutes == 60
        hours += 1
        minutes = 0
      end
    end

    if minutes == 0
      t('hours', :count => hours.to_i)
    elsif hours < 1
      t('minutes_without_hours', :count => minutes)
    else
      t('hours_with_minutes', :count => hours.to_i, :minutes => minutes)
    end
  end

  def human_seconds(seconds)
    "#{human_hours(seconds.to_f/60/60)}"
  end

  def gravatar_url(user, opts = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    if opts[:size] == 'square'
      "https://gravatar.com/avatar/#{gravatar_id}.png?default=identicon&s=25"
    else
      "https://gravatar.com/avatar/#{gravatar_id}.png?default=identicon"
    end
  end
end
