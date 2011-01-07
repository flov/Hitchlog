module TripsHelper
  def trip_date(trip)
    @month_array ||= []
    if !trip.date.nil? && !@month_array.include?(trip.date.strftime("%B%y"))
      @month_array << trip.date.strftime("%B%y")
      date = trip.date.strftime("<h3 class='date'>%B<strong>%y</strong></h3>").html_safe unless trip.date.nil?
    else
      date = ''
    end
    date
  end
  
  def link_to_trip(trip, options ={})
    array = []
    array << photo_image unless trip.hitchhikes.collect{|h| h.photo.file?}.delete_if{|x|!x}.compact.empty?
    array << story_image unless trip.hitchhikes.collect{|h| h.story}.compact.delete_if{|x| x==''}.empty?
    unless trip.hitchhikes.collect{|h| h.person.nil?}.compact.delete_if{|x|x==true}.empty?
      array << user_image.html_safe
    end
    string = "#{h(trip.from)} &rarr; #{h(trip.to)} (#{distance(trip.distance)}), #{pluralize(trip.hitchhikes.size, 'ride')}".html_safe
    if array.empty?
      string << ", no information"
    else
      string << ", with #{array.join(' ')}".html_safe 
    end
    
    string << ", #{link_to(add_image, trip_path(trip))}".html_safe if current_user == trip.user
    
    if array.empty?
      string.html_safe
    elsif options[:remote] == true
      link_to(string, trip_path(trip), {:class => 'trip', :rel => trip.id}).html_safe
    else
      link_to(string, trip_path(trip)).html_safe
    end
  end
  
end
