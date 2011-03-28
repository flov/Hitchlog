class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_trip_and_redirect_if_not_owner, :only => [:edit, :router]
  
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
      redirect_to router_user_trip_path(current_user, @trip)
    else
      render :new
    end
  end

  def router
  end
  
  def index
    @trips = Trip.order("start ASC").paginate(:page => params[:page], :per_page => 20)
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
      flash[:notice] = "Successfully updated trip."
      redirect_to trip_path(@trip)
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

  private

  def find_trip_and_redirect_if_not_owner
    @trip = Trip.find(params[:id])
    if @trip.user != current_user
      flash[:error] = "This is not your trip."
      redirect_to trips_path
    end
  end
end
