class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_trip_and_redirect_if_not_owner, :only => [:edit]

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
    @user = @trip.user
    @photo_rides = @trip.rides.select{|ride| ride.photo.file?}
    @rides = @user.trips.map{|trip| trip.rides}.flatten
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.user = current_user
    if @trip.save
      redirect_to edit_trip_path(@trip)
    else
      render :new
    end
  end

  def index
    @trips = Trip
    unless params[:country].blank?
      @trips = @trips.includes(:country_distances).where(:country_distances => {:country => params[:country]})
    end
    if params[:stories]
      @trips = @trips.includes(:rides).where("rides.story IS NOT NULL AND rides.story != ''")
    end
    if params[:photos]
      @trips = @trips.includes(:rides).where("rides.photo_file_name IS NOT NULL")
    end
    @trips = @trips.paginate(:page => params[:page])
    respond_to do |wants|
      wants.html
      wants.js { render :partial => 'trips/trips', :locals => {:trips => @trips} }
    end
  end

  def edit
    @trip.rides.each do |ride|
      if ride.person.nil?
        ride.build_person
      end
    end
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(params[:trip])
      respond_to do |wants|
        wants.html { redirect_to edit_trip_path(@trip) }
        wants.js {}
      end
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
