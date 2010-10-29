class Hitchhike
  validates_presence_of :from, :to, :distance
  validates_numericality_of :distance

  before_validation do
    self.distance = Gmaps.distance(self.from, self.to)
  end
  
  def validate
  	if distance == 0
  		errors.add(:distance, "cannot find a route from #{self.from} to #{self.to}")
  	end
  end
end