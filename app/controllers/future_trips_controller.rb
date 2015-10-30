class FutureTripsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  expose(:future_trips) { FutureTrip.relevant.earliest_departing.paginate(page: params[:page], per_page: 10) }
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
    if future_trip.update_attributes(future_trip_params)
      redirect_to user_path(current_user)
    else
      render action: :edit
    end
  end

  def destroy
    flash[:success] = t('general.deleted', from: future_trip.from, to: future_trip.to)
    future_trip.destroy
    redirect_to user_path(current_user)
  end

  private

  def future_trip_params
    params.require("future_trip").permit(
      :from,
      :from_lat,
      :from_lng,
      :from_city,
      :from_country,
      :from_country_code,
      :departure,
      :to,
      :to_lat,
      :to_lng,
      :to_city,
      :to_country,
      :to_country_code,
      :description
    )
  end

  def future_trip_in_context
    if params[:id]
      FutureTrip.find(params[:id])
    else
      if params['future_trip']
        FutureTrip.new(future_trip_params)
      else
        FutureTrip.new
      end
    end
  end
end
