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
    params[:search] ||= {"meta_sort"=>"last_sign_in_at.desc"}
    @search = User.search(params[:search])
    @users = @search.paginate(:page => params[:page], :per_page => 10)
  end
end
