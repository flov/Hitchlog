class BuddiesController < ApplicationController
  expose(:future_travels) { FutureTravel.all }
end
