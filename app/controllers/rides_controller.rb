class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:next, :prev, :show, :index]

  expose( :ride )

  def create
    ride.trip = Trip.find(params[:trip_id])
    if ride.save
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(ride.trip)
      else
        render action: "crop"
      end
    else
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def delete_photo
    if ride.delete_photo!
      redirect_to edit_trip_path(ride.trip)
    else
      flash[:alert] = 'Could not delete photo'
      render :edit
    end
  end
  
  def update
    if ride.update_attributes(params[:ride])
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(ride.trip)
      else
        render action: "crop"
      end
    else
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def destroy
    if ride.trip.user == current_user
      ride.destroy
      flash[:notice] = "Successfully destroyed ride."
    else
      flash[:alert] = "You are not allowed to do that!"
    end
    redirect_to edit_trip_path(ride.trip)
  end
end
