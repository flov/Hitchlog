class WelcomeController < ApplicationController
  expose(:future_trips) { future_trips_in_context }

  def home
    redirect_to '/en' unless params[:locale]
  end

  private

  def future_trips_in_context
    FutureTrip.relevant.order(:departure).paginate(page: params[:page], per_page: 5)
  end
end
