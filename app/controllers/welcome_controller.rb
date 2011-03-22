class WelcomeController < ApplicationController
  include Chart

  def home
    @hitchhike = Hitchhike.random_item
    #@chart_image_header = chart_image(Trip.all, nil, :three_dimensional => true, :color => 'FFAC63', :size => 'small')

    @chart_image = chart_image(Trip.all)
    @trips = Trip.all.paginate :per_page => 5, :page => 1
    @trip_size = @trips.size
    @country_size = @trips.map(&:from_country).uniq.size
    @active_hitchhikers = @trips.map(&:user).uniq.size
    @hitchhike_size = Hitchhike.all.size
    @story_size = Hitchhike.all.collect{|hh| hh.story}.flatten.compact.delete_if{|x|x==''}.size
    @photo_size = Hitchhike.with_photo.size
    @hitchhiked_km = @trips.collect{|t| t.distance}.flatten.compact.sum / 1000
    @hitchhikes_with_story = Hitchhike.with_story.order("updated_at DESC").paginate :per_page => 5, :page => params[:page]
    @hitchhikers = User.order("created_at DESC").paginate :per_page => 5, :page => 1
  end
  
  def about
    @flov = User.find_by_username('flov')
    @hitchhikers_with_trips = User.all.collect{|user| user unless user.trips.nil? }.compact
  end
end
