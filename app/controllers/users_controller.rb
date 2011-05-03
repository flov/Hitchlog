class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]
  
  def show
    @user = User.find(params[:id])
    get_user_settings(@user)

    @trips = @user.trips.paginate(:page => params[:page], :per_page => 20)

    @rides   = @user.trips.collect{|trip| trip.rides}.flatten
    @total_distance = @user.trips.collect{|trip| trip.distance if trip.distance > 0}.compact.sum / 1000
    @waiting_time_array = @rides.collect{|ride| ride.waiting_time}.flatten.compact
    @number_of_photos = @rides.collect{|h| h.photo.file? }.delete_if{|x| x==false}.compact.size
    @longest_trip = @trips[@trips.index{|x| x.distance==@trips.collect{|t| t.distance}.max}] unless @trips.empty?
  end
  
  def edit
    @trips = current_user.trips
  end
  
  def index
    @users = User.order('users.username ASC').all
  end
end
