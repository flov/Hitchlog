class FutureTripsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  expose(:future_trips) { FutureTrip.scoped }
  expose(:future_trip)  { future_trip_in_context }

  def create
    future_trip.user_id = current_user.id
    if future_trip.save
      redirect_to user_path(current_user)
    else
      render action: :new
    end
  end

  def update
    if future_trip.update_attributes params[:future_trip]
      redirect_to user_path(current_user)
    else
      render action: :edit
    end
  end

  def destroy
    flash[:success] = t('flash.future_trips.destroy.success', from: future_trip.from, to: future_trip.to)
    future_trip.destroy
    redirect_to user_path(current_user)
  end

  private

  def future_trip_in_context
    if params[:id]
      FutureTrip.find(params[:id])
    else
      FutureTrip.new(params[:future_trip])
    end
  end
end
