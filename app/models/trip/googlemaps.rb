class Trip
  include Gmaps
  
  def compute_distance
    self.distance = Gmaps.distance(from, to)
  end

  def compute_distance!
    compute_distance
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

  before_update do
    compute_distance
    get_country
  end

  before_validation do
    compute_distance
    get_country
  end
end
