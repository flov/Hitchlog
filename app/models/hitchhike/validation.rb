class Hitchhike
  # custom functions to get distances
  include Gmaps

  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true

  def compute_distance!
    self.distance = Gmaps.distance(self.from, self.to)
  end

  before_validation do
    compute_distance!
  end
end