module HitchhikesHelper
  def distance(distance_in_meters)
    if distance_in_meters > 0
      "#{distance_in_meters / 1000} km" 
    elsif distance_in_meters == -5
      "no results for this route"
    else
      "unknown distance"
    end
  end
end