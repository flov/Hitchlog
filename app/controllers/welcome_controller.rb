class WelcomeController < ApplicationController
  include Chart

  def home
    @chart_image = chart_image(Trip.all)
    @trip_size = Trip.count
    @country_size = CountryDistance.all.map(&:country).uniq.size
    @active_hitchhikers = User.all.size
    @hitchhike_size = Ride.all.size
    @story_size = Ride.all.map(&:story).flatten.compact.delete_if{|x|x==''}.size
    @photo_size = Ride.with_photo.count
    @hitchhiked_km = Trip.all.map(&:distance).sum / 1000
    @rides_with_story = Ride.with_story.order("id DESC").paginate :per_page => 2, :page => 1
    @hitchhikers = User.order("id DESC").paginate :per_page => 5, :page => 1
    @trips = Trip.order('id DESC').paginate :per_page => 5, :page => 1
  end

  def about
    @flov = User.find_by_username('flov')
    @hitchhikers_with_trips = User.all.collect{|user| user unless user.trips.nil? }.compact
  end
end
