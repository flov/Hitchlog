module ApplicationHelper
  def javascript_google_stats
    render :partial => 'shared/google_stats'
  end
  
  def include_modernizr_js
    if Rails.env == "production"
      javascript_include_tag 'vendor/modernizr-2.0-production.js' 
    else Rails.env == "development"
      javascript_include_tag 'vendor/modernizr-2.0-development.js' 
    end
  end
  
  def uservoice_feedback
    render :partial => 'shared/uservoice_feedback'
  end
  
  def seconds_to_hours(seconds)
    secounds/60/60
  end

  def human_minutes(minutes)
    "#{minutes} minutes"
  end

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
    else
      t('hours_with_minutes', :count => hours.to_i, :minutes => minutes)
    end
  end  
  
  def human_minutes(minutes)
    "#{minutes}min"
  end

  def human_seconds(seconds)
    "#{human_hours(seconds/60/60)}"
  end

  def number_to_ordinal(num)
    num = num.to_i
    if (10...20)===num
      "#{num}th"
    else
      g = %w{ th st nd rd th th th th th th }
      a = num.to_s
      c=a[-1..-1].to_i
      a + g[c]
    end
  end  
end
