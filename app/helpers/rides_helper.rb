module RidesHelper
  def distance(distance_in_meters)
    if distance_in_meters > 0
      "#{number_with_delimiter( distance_in_meters / 1000 )}km" 
    elsif distance_in_meters == -5
      I18n.t('helper.no_results_for_this_route')
    else
      I18n.t('helper.unknown_distance')
    end
  end
end
