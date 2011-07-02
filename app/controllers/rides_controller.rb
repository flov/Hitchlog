class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:json, :show, :index]

  def json
    if params[:id]
      render :json => Ride.find(params[:id]).to_json
    else
      render :json => Ride.random_item.to_json
    end
  end

  def show
    @ride = Ride.find(params[:id])
    respond_to do |wants|
      wants.html
      wants.json { render :json => @ride.to_json }
    end
  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.trip = Trip.find(params[:trip_id])
    if @ride.save
      if params[:ride][:photo].blank?
        redirect_to trip_path(@ride.trip)
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end

  def delete_photo
    @ride = Ride.find(params[:id])  
    if @ride.delete_photo!
      redirect_to edit_ride_path(@ride)
    else
      flash[:error] = 'Could not delete photo'
      render :edit
    end
  end
  
  def edit
    @ride = Ride.find(params[:id])
    @ride.build_person
    @trip = @ride.trip
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(params[:ride])
      if params[:ride][:photo].blank?
        redirect_to trip_path(@ride.trip)
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @ride = Ride.find(params[:id])
    if @ride.trip.user == current_user
      @ride.destroy
      flash[:notice] = "Successfully destroyed ride."
    else
      flash[:error] = "You are not allowed to do that!"
    end
    redirect_to trips_url
  end
end
