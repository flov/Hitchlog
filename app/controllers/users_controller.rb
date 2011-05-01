class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]
  
  def show
    @user = User.where(:username => params[:id]).first
    @trips = @user.trips.paginate(:page => params[:page], :per_page => 20)
    
    @rides   = @user.trips.collect{|trip| trip.rides}.flatten
    @total_distance = @user.trips.collect{|trip| trip.distance if trip.distance > 0}.compact.sum / 1000
    @waiting_time_array = @rides.collect{|ride| ride.waiting_time}.flatten.compact
    @total_waiting_time   = @waiting_time_array.sum
    @average_waiting_time = @total_waiting_time / @waiting_time_array.size unless @waiting_time_array.size == 0    
    @stories = @rides.collect{|h| h.story}.compact.delete_if{|x| x == ''}
    @number_of_photos = @rides.collect{|h| h.photo.file? }.delete_if{|x| x==false}.compact.size
    @longest_trip = @trips[@trips.index{|x| x.distance==@trips.collect{|t| t.distance}.max}] unless @trips.empty?
    
    avg_drivers_age_array = @rides.collect{|h| h.person.age if h.person}.compact
    @avg_drivers_age = avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    
  end
  
  def edit
    @trips = current_user.trips
  end
  
  def index
    @users = User.order('users.username ASC').all
  end
end
