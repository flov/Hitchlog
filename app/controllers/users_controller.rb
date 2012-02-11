class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :destroy, :update]

  def show
    @user = User.find(params[:id])
    @rides = @user.trips.map{|trip| trip.rides}.flatten
    @x_times_alone = @user.trips.select {|trip| trip.travelling_with == 0}.size
    @x_times_with_two = @user.trips.select {|trip| trip.travelling_with == 1}.size
    @x_times_with_three = @user.trips.select {|trip| trip.travelling_with == 2}.size
    @x_times_with_four = @user.trips.select {|trip| trip.travelling_with == 3}.size

    @trips = @user.trips
    unless params[:country].blank?
      @trips = @trips.includes(:country_distances).where(:country_distances => {:country => params[:country]})
    end
    if params[:stories]
      @trips = @trips.includes(:rides).where("rides.story IS NOT NULL AND rides.story != ''")
    end
    if params[:hitchhiked_with]
      @trips = @trips.where(travelling_with: params[:hitchhiked_with])
    end
    if params[:photos]
      @trips = @trips.includes(:rides).where("rides.photo_file_name IS NOT NULL")
    end
    @trips = @trips.order("trips.id DESC").paginate(:page => params[:page])
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
    @users = @search.result.order('current_sign_in_at DESC').paginate(:page => params[:page], :per_page => 10)
  end
end
