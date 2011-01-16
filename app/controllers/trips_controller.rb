class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def new
    @trip = Trip.new
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
  
  def create
    @trip = Trip.new(params[:trip])
    @trip.user = current_user
    if @trip.save
      flash[:notice] = "Thanks for creating a new trip. Please provide more information below."
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end
  
  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 60)
    respond_to do |wants|
      wants.html
      wants.js { render :partial => 'trips/trips', :locals => {:trips => @trips} }
    end
  end
  
  def edit
    @trip  = Trip.find(params[:id])
    unless @trip.user == current_user
      flash[:error] = "This is not your trip."
      redirect_to trips_path
    end
  end
    
  def update
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(params[:trip])
      flash[:notice] = "Successfully updated trip."
      redirect_to trips_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    flash[:notice] = "Successfully destroyed trip."
    redirect_to trips_url
  end  
end
