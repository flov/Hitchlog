class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]

  def show
    @user = User.find(params[:id])
    @trips = @user.trips.paginate(:page => params[:page], :per_page => 20)
    @rides = @user.trips.map{|trip| trip.rides}.flatten
  end

  def edit
    @trips = current_user.trips
  end

  def index
    @users = User.order('users.username ASC').paginate(:page => params[:page], :per_page => 10)
  end
end
