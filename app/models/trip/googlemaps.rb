class Trip
  include Gmaps
  
  def get_distance
    self.distance = Gmaps.distance(from, to)
  end

  def get_country_distance
    Gmaps.countries(from, to).each do |country_distance|
      cd = CountryDistance.where(:country => country_distance[0],
                                 :trip_id => self.id)
      if cd.empty?
        self.country_distances.create(:country  => country_distance[0],
                                      :distance => country_distance[1])
      elsif cd.first.distance != country_distance
        cd.first.update_attribute :distance, country_distance[1]
      end
    end
  end

  def get_distance!
    get_distance
    save!
  end

  def get_city
    self.from_city = Gmaps.city(from)
    self.to_city   = Gmaps.city(to)
  end

  def get_city!
    get_city
    save!
  end

  def get_country
    self.from_country = Gmaps.country(from)
    self.to_country   = Gmaps.country(to)
  end

  def get_country!
    get_country
    save!
  end

  def get_formatted_addresses
    self.formatted_from = Gmaps.formatted_address(from)
    self.formatted_to = Gmaps.formatted_address(to)
  end

  def get_formatted_addresses!
    get_formatted_addresses
    save!
  end

  before_validation do
    get_country
    get_formatted_addresses
    get_city
    get_distance
  end

  after_create do
    get_country_distance
  end
end
