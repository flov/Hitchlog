class WelcomeController < ApplicationController
  expose(:future_trips) { future_trips_in_context }

  def home
    if not params[:locale] and not Rails.env == 'test' # I18n filter is disabled for test env
      redirect_to '/en'
    end
  end

  private

  def future_trips_in_context
    FutureTrip.relevant.order(:departure).paginate(page: params[:page], per_page: 5)
  end
end
