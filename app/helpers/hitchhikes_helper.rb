module HitchhikesHelper
  def distance(distance_in_meters)
    if distance_in_meters > 0
      "#{number_with_delimiter( distance_in_meters / 1000 )}km" 
    elsif distance_in_meters == -5
      "no results for this route"
    else
      "unknown distance"
    end
  end
  
  def hitchhike_show_title(hitchhike)
    title("Hitchhiking from #{@hitchhike.trip.from_city_sanitized} to #{@hitchhike.trip.to_city_sanitized}")
  end

  def show_photo_link(hitchhike)
    "(#{link_to 'photo link', hitchhike.photo(:large)})".html_safe if hitchhike.photo.file?
  end

  def show_ordinal_of_ride(hitchhike)
    number_to_ordinal(hitchhike.no_in_trip)
  end
  
  def trip_took(hitchhike)
    if !hitchhike.trip.start.blank? and !hitchhike.trip.end.blank?
      "trip took #{human_seconds(hitchhike.trip.end - hitchhike.trip.start)}" 
    elsif hitchhike.trip.duration
      "trip took #{human_hours(hitchhike.trip.duration)}" 
    end
  end

  def ride_took(hitchhike)
    "ride took #{human_hours(hitchhike.duration)}" if hitchhike.duration
  end
  
  def trip_and_ride_took(hitchhike)
    [ride_took(hitchhike), trip_took(hitchhike)].compact.join(', ')
  end
  
  def link_to_hitchhike(hitchhike, i)
    if hitchhike.empty?
      "#{number_to_ordinal(i+1)} Ride"
    else
      link_to "#{number_to_ordinal(i+1)} Ride", hitchhike_path(hitchhike)
    end
  end
  
  def this_is_your_hitchhike(user)
    if current_user == user
      "This is your entry, #{link_to 'edit hitchhike', edit_hitchhike_path(@hitchhike)} | #{link_to 'edit trip', edit_trip_path(@hitchhike.trip)}".html_safe 
    end
  end

  def link_to_ride_for_button(i, hitchhike, current_hitchhike=nil)
    if hitchhike.empty? 
      "<div class='#{hitchhike_button_class(i, hitchhike, current_hitchhike)}'>#{number_to_ordinal(i+1)} ride</div>".html_safe
    else
      link_to "#{number_to_ordinal(i+1)} ride".html_safe, hitchhike_path(hitchhike), :class => hitchhike_button_class(i, hitchhike, current_hitchhike)
    end
  end

  def hitchhike_button_class(i, hitchhike, current_hitchhike=nil)
    array = []
    array << 'hitchhike_button'
    if i == 0 and i == (hitchhike.trip.hitchhikes.size - 1)
      array << 'first_and_last'
    elsif i == 0
      array << 'first'
    elsif i == (hitchhike.trip.hitchhikes.size - 1)
      array << 'last'
    end
    if !current_hitchhike.nil? and hitchhike == current_hitchhike
      array << 'current'
    end
    unless hitchhike.empty?
      array << 'active'
    end
    array.join ' '
  end
  
  def div_attributes_for_hitchhike_button(i, hitchhike, comparing_hitchhike = nil)
    array = []
    if i == 0 and i == (comparing_hitchhike.trip.hitchhikes.size - 1)
      array << 'first_and_last'
    elsif i == 0
      array << 'first'
    elsif i == (comparing_hitchhike.trip.hitchhikes.size - 1)
      array << 'last'
    end
    if comparing_hitchhike.nil? and hitchhike == comparing_hitchhike
      array << 'current'
    end
    if !hitchhike.empty?
      array << 'active'
    end
    array.join ' '
  end

end
