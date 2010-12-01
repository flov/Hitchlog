class Trip
  include Gmaps
  
  def compute_distance!
    self.distance = Gmaps.distance(self.from, self.to)
  end

  before_update do
    compute_distance!
  end

  before_validation do
    compute_distance!
  end
end