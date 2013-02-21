class BuddiesController < ApplicationController
  expose(:future_trips) { FutureTrip.all }
end
