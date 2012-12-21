class FutureTripsController < ApplicationController
  expose(:future_trips) {FutureTrip.all}
  expose(:future_trip)
end
