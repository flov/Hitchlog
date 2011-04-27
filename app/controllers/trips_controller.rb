class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_trip_and_redirect_if_not_owner, :only => [:edit]
  
  def new
    @trip = Trip.new
  end
  
  def show
    @trip = Trip.find(params[:id])
    @user = @trip.user
    @hitchhiked_kms = @user.trips.map{|trip| trip.distance}.sum/1000.0
    @hitchhiked_countries = @user.trips.map{|trip| trip.country_distances.map{|cd|cd.country}}.flatten.uniq
    @rides = @user.trips
    waiting_time = @user.trips.map{|trip| trip.hitchhikes.map{|hh| hh.waiting_time}}.flatten.compact
    if waiting_time.size == 0
      @average_waiting_time = nil
    else
      @average_waiting_time = waiting_time.sum / waiting_time.size
    end
    @photos = @trip.hitchhikes.map{|t| t.photo}.delete_if{|photo| !photo.file?}
  end
  
  def create
    @trip = Trip.new(params[:trip])
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end
  
  def index
    @trips = Trip.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
    @hitchhikes = Hitchhike.not_empty
    respond_to do |wants|
      wants.html
      wants.js { render :partial => 'trips/trips', :locals => {:trips => @trips} }
    end
  end
  
  def edit
  end
    
  def update
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(params[:trip])
      redirect_to trip_path(@trip)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_url
  end  

  private

  def find_trip_and_redirect_if_not_owner
    @trip = Trip.find(params[:id])
    if @trip.user != current_user
      flash[:error] = "This is not your trip."
      redirect_to trips_path
    end
  end
end
