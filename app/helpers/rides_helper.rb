module RidesHelper
  def distance(distance_in_meters)
    if distance_in_meters > 0
      "#{number_with_delimiter( distance_in_meters / 1000 )}km" 
    elsif distance_in_meters == -5
      "no results for this route"
    else
      "unknown distance"
    end
  end

  def ride_title(ride)
    if ride.title.blank?
      ride.story.truncate(30)
    else
      ride.title
    end
  end
  
  def hitchhike_show_title(hitchhike)
    title("Hitchhiking from #{hitchhike.trip.from_city_sanitized} to #{hitchhike.trip.to_city_sanitized}")
  end

  def trip_show_title(trip)
    title("Hitchhiking from #{trip.from_city_sanitized} to #{trip.to_city_sanitized}")
  end

  def show_photo_link(hitchhike)
    "(#{link_to 'photo link', hitchhike.photo(:large)})".html_safe if hitchhike.photo.file?
  end

  def show_ordinal_of_ride(ride)
    number_to_ordinal(ride.no_in_trip)
  end
  
  def trip_took(ride)
    if !ride.trip.start.blank? and !ride.trip.end.blank?
      "trip took #{human_seconds(ride.trip.end - ride.trip.start)}" 
    elsif ride.trip.duration
      "trip took #{human_hours(ride.trip.duration)}" 
    end
  end

  def ride_took(ride)
    "ride took #{human_hours(ride.duration)}" if ride.duration
  end
  
  def trip_and_ride_took(ride)
    [ride_took(ride), trip_took(ride)].compact.join(', ')
  end
  
  def link_to_hitchhike(ride, i)
    if ride.empty?
      "#{number_to_ordinal(i+1)} Ride"
    else
      link_to "#{number_to_ordinal(i+1)} Ride", ride_path(ride)
    end
  end
  
  def link_to_ride_for_button(i, ride, current_ride=nil)
    if ride.empty? 
      "<div class='#{hitchhike_button_class(i, ride, current_ride)}'>#{number_to_ordinal(i+1)} ride</div>".html_safe
    else
      link_to "#{number_to_ordinal(i+1)} ride".html_safe, ride_path(ride), :class => hitchhike_button_class(i, ride, current_ride)
    end
  end

  def delete_ride(ride)
    link_to delete_ride_image, ride_path(ride), :remote => :true, :method => :delete, :confirm => 'Are you sure?'
  end

  def hitchhike_button_class(i, ride, current_ride=nil)
    array = []
    array << 'hitchhike_button'
    if i == 0 and i == (ride.trip.rides.size - 1)
      array << 'first_and_last'
    elsif i == 0
      array << 'first'
    elsif i == (ride.trip.rides.size - 1)
      array << 'last'
    end
    if !current_ride.nil? and ride == current_ride
      array << 'current'
    end
    unless ride.empty?
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
