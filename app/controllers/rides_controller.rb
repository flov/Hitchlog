class RidesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_owns_ride, except: [:create]

  expose( :ride ) { ride_in_context }

  def create
    ride.trip = Trip.find(params[:trip_id])

    if ride.trip.user != current_user
      flash[:alert] = t('general.not_allowed')
      redirect_to root_path
      return
    end

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
      flash[:alert] = t('flash.rides.delete_photo.error')
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def update
    ride = Ride.find(params[:id])
    if not ride.update_attributes(ride_params)
      flash[:alert] = t('flash.error')
    end
    redirect_to edit_trip_path(ride.trip)
  end

  def destroy
    ride.destroy
    flash[:success] = "This ride is no more. HAHAHAHAAAAA *Evil laughter*"
    redirect_to user_path(current_user)
  end

  private

  def ride_in_context
    if params['id']
      Ride.find(params["id"])
    else
      Ride.new
    end
  end

  def ride_params
    params.require("ride").permit(
      :experience,
      :title,
      :story,
      :tag_list,
      :photo_cache,
      :photo_caption,
      :vehicle,
      :waiting_time,
      :duration,
      :gender,
      :date,
      :number,
      :photo
    )
  end

  def user_owns_ride
    if ride.trip.user != current_user
      flash[:alert] = t('general.not_allowed')
      redirect_to root_path
      return
    end
  end
end
