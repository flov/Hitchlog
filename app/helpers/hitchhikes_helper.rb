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
  
  def show_attribute(name, attribute, options = {})
    unless attribute.blank?
      if options[:time] == :minutes
        attribute = "#{attribute} minutes"
      elsif options[:time] == :hours
        attribute = "#{attribute} hours"
      end
      "#{name}: #{h(attribute)}<br/>".html_safe
    end
  end
  
  def link_to_hitchhike(hitchhike)
    if hitchhike.empty?
      "no information"
    else
      link_to "show", hitchhike_path(hitchhike)
    end
  end
end