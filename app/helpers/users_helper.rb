module UsersHelper
  def link_to_trip(trip)
    array = []
    array << "picture" if !trip.hitchhikes.collect{|h| h.photo.file?}.delete_if{|x|!x}.compact.empty?
    array << "story"   if !trip.hitchhikes.collect{|h| h.story}.compact.empty?
    array << "person"  if !trip.hitchhikes.collect{|h| h.person.to_s}.compact.delete_if{|x|x==''}.empty?
    string = "#{h(trip.from)} &rarr; #{h(trip.to)} (#{distance(trip.distance)}), #{pluralize(trip.hitchhikes.size, 'ride')}".html_safe
    string << ", with #{array.join(', ')}" unless array.empty?
    if array.empty?
      string
    else
      link_to string, trip_path(trip)
    end
  end
end
