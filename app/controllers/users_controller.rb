class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]
  
  def show
    @user = User.where(:username => params[:id]).first
    @trips = @user.trips.order("date DESC")
    @hitchhikes   = @user.trips.collect{|trip| trip.hitchhikes}.flatten
    @total_distance = @user.trips.collect{|trip| trip.distance if trip.distance > 0}.compact.sum / 1000
    @waiting_time_array = @hitchhikes.collect{|hitchhike| hitchhike.waiting_time}.flatten.compact
    @total_waiting_time   = @waiting_time_array.sum
    @average_waiting_time = @total_waiting_time / @waiting_time_array.size unless @waiting_time_array.size == 0    
    
    avg_drivers_age_array = @hitchhikes.collect{|h| h.person.age}.compact
    @avg_drivers_age = avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    
  end
  
  def edit
    @trips = current_user.trips
  end
  
  def index
    @users = User.all
  end
end
