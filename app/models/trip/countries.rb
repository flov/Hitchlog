class Trip
  def countries
    self.country_distances.map(&:country)
  end

  def countries_with_distance
    self.country_distances.map{|t| {:country => t.country, :distance => t.distance} }
  end
end
