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
  
  def link_to_trip(trip)
    array = []
    array << "picture" if !trip.hitchhikes.collect{|h| h.photo.file?}.delete_if{|x|!x}.compact.empty?
    array << "story"   if !trip.hitchhikes.collect{|h| h.story}.compact.empty?
    array << "person"  if !trip.hitchhikes.collect{|h| h.person.to_s}.compact.delete_if{|x|x==''}.empty?
    string = "#{h(trip.from)} &rarr; #{h(trip.to)} (#{distance(trip.distance)}), #{pluralize(trip.hitchhikes.size, 'ride')}".html_safe
    string << ", with #{array.join(', ')}" unless array.empty?
    # if array.empty?
    #   string
    # else
    link_to string, trip_path(trip), {:class => 'trip', :rel => trip.id}
    # end
  end
  
end
