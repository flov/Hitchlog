class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]
  
  def show
    @user = User.where(:username => params[:id]).first
    @trips = @user.trips.order("date DESC")
    @total_distance = @user.trips.collect{|hitchhike| hitchhike.distance if hitchhike.distance > 0}.compact.sum / 1000
    @hitchhikes   = @user.trips.collect{|trip| trip.hitchhikes}.flatten
    @waiting_time_array = @hitchhikes.collect{|hitchhike| hitchhike.waiting_time}.flatten.compact
    @total_waiting_time   = @waiting_time_array.sum
    @average_waiting_time = @total_waiting_time / @waiting_time_array.size unless @waiting_time_array.size == 0
  end
  
  def edit
    @trips = current_user.trips
  end
  
  def index
    @users = User.all
  end
end
