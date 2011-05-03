class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    user_path(current_user.to_s.downcase)
  end

  protected

  # used by UsersController and TripsController
  def get_user_settings(user)
    @hitchhiked_kms = user.trips.map{|trip| trip.distance}.sum/1000.0
    @hitchhiked_countries = user.trips.map{|trip| trip.country_distances.map{|cd|cd.country}}.flatten.uniq
    @rides = @user.trips.map{|trip| trip.rides}.flatten
    waiting_time = @user.trips.map{|trip| trip.rides.map{|hh| hh.waiting_time}}.flatten.compact
    if waiting_time.size == 0
      @average_waiting_time = nil
    else
      @average_waiting_time = waiting_time.sum / waiting_time.size
    end

    avg_drivers_age_array = @rides.collect{|h| h.person.age if h.person}.compact
    @average_drivers_age = avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    

    @average_drivers_age = avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    
    @stories = @rides.collect{|h| h.story}.compact.delete_if{|x| x == ''}

    @number_of_photos = @rides.collect{|h| h.photo.file? }.delete_if{|x| x==false}.compact.size
  end
end
