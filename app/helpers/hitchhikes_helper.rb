module HitchhikesHelper
  def distance(distance_in_meters)
    if distance_in_meters > 0
      "#{distance_in_meters / 1000}km" 
    elsif distance_in_meters == -5
      "no results for this route"
    else
      "unknown distance"
    end
  end
  
  def show_photo_link(hitchhike)
    "(#{link_to 'photo link', hitchhike.photo(:large)})".html_safe if hitchhike.photo.file?
  end

  def show_ordinal_of_ride(hitchhike)
    "#{number_to_ordinal(hitchhike.no_in_trip)} ride"
  end
  
  def show_attribute(name_of_attr, attribute, options = {})
    unless attribute.blank?
      if options[:time] == :minutes
        attribute = "#{attribute} minutes"
      end
      if name_of_attr == 'Story'
        attribute = truncate(attribute)
      end
      "#{name_of_attr}: #{attribute}<br/>".html_safe
    end
  end
  
  def show_available_images_for_attributes(hitchhike)
    array = []
    array << photo_image if hitchhike.photo.file?
    array << user_image if hitchhike.person
    array << story_image if hitchhike.story
    string = array.join(' ')
    string.html_safe
  end
  
  def link_to_hitchhike(hitchhike)
    if hitchhike.empty?
      "no information"
    else
      link_to "show this hitchhike", hitchhike_path(hitchhike)
    end
  end
  
  def this_is_your_hitchhike(user)
    "This is your entry, #{link_to 'edit this hitchhike', edit_hitchhike_path(@hitchhike)}".html_safe if current_user == user
  end
  
  def human_hours(hours)
    hours = (hours.to_f * 100).round.to_f / 100

    if hours > 0
      minutes = ((hours % 1) * 60).round
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