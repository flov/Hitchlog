class User
  def hitchhiked_kms
    self.trips.map{|trip| trip.distance}.sum/1000
  end

  def hitchhiked_countries
    self.trips.map{|trip| trip.country_distances.map{|cd|cd.country}}.flatten.uniq.size
  end

  def rides
    self.trips.map{|trip| trip.rides}.flatten
  end

  def hitchhiked_cars
    self.rides.size
  end

  def average_waiting_time
    waiting_time = self.trips.map{|trip| trip.rides.map{|hh| hh.waiting_time}}.flatten.compact
    if waiting_time.size == 0
      nil
    else
      waiting_time.sum / waiting_time.size
    end
  end

  def average_drivers_age
    avg_drivers_age_array = self.rides.collect{|h| h.person.age if h.person}.compact
    avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    
  end

  def stories
    self.rides.collect{|h| h.story}.compact.delete_if{|x| x == ''}
  end

  def number_of_photos
    self.rides.collect{|h| h.photo.file? }.delete_if{|x| x==false}.compact.size
  end
end
