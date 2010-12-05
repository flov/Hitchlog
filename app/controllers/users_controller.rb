class UsersController < ApplicationController
  def show
    @user = User.where(:username => params[:id]).first
    @total_distance = @user.trips.collect{|hitchhike| hitchhike.distance if hitchhike.distance > 0}.compact.sum / 1000
    @waiting_time = @user.hitchhikes.collect{|hitchhike| hitchhike.waiting_time}.compact
    @total_waiting_time   = @waiting_time.sum
    @average_waiting_time = @total_waiting_time / @waiting_time.size unless @waiting_time.size == 0
  end
  
  def index
    @users = User.all
  end
end
