class Trip
  include Gmaps
  
  def compute_distance
    self.distance = Gmaps.distance(from, to)
  end

  def compute_distance!
    compute_distance
    save!
  end

  before_update do
    compute_distance
  end

  before_validation do
    compute_distance
  end
end