class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :destroy, :update]

  def show
    @user = User.find(params[:id])
    @trips = @user.trips
    @rides = @trips.map{|trip| trip.rides}.flatten
    @x_times_alone = @trips.select {|trip| trip.travelling_with == 0}.size
    @x_times_with_two = @trips.select {|trip| trip.travelling_with == 1}.size
    @x_times_with_three = @trips.select {|trip| trip.travelling_with == 2}.size
    @x_times_with_four = @trips.select {|trip| trip.travelling_with == 3}.size
    @trips = @trips.paginate(:page => params[:page], :per_page => 20)
  end

  def edit

  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t('flash.users.update.notice')
      redirect_to user_path(@user)
    else
      flash[:error] = I18n.t('flash.users.update.error')
      render :action => 'edit'
    end
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(:page => params[:page], :per_page => 10)
  end
end
