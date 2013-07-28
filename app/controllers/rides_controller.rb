class RidesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_owns_ride

  expose( :ride )

  def create
    ride.trip = Trip.find(params[:trip_id])
    if ride.save
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def delete_photo
    ride.remove_photo!
    if ride.save!
      flash[:success] = t('flash.rides.delete_photo.success')
      redirect_to edit_trip_path(ride.trip)
    else
      flash[:alert] = 'Could not delete photo'
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def update
    if not ride.update_attributes(params[:ride])
      flash[:alert] = t('flash.error')
    end
    redirect_to edit_trip_path(ride.trip)
  end

  def destroy
    ride.destroy
    flash[:success] = "Successfully destroyed ride."
    redirect_to edit_trip_path(ride.trip)
  end

  private

  def user_owns_ride
    if ride.trip.user != current_user
      flash[:alert] = "You are not allowed to do that!"
      redirect_to root_path
      return
    end
  end
end
