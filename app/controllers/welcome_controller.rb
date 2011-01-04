class WelcomeController < ApplicationController
  def index
    @hitchhike = Hitchhike.random_item
  end
  
  def about
    @flov = User.find_by_username('flov')
    @hitchhikers_with_trips = User.all.collect{|user| user unless user.trips.nil? }.compact
  end
end
