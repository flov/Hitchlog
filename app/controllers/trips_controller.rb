class TripsController < ApplicationController
  expose!( :trip ) { trip_in_context }
  expose( :trips ) { trips_in_context }

  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_trip_owner, only: [:edit, :update, :destroy, :add_ride]

  def index
    @q = Trip.latest_first.ransack(params[:q])
    @trips = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
  end

  def create
    trip.user = current_user
    countries = JSON.parse(trip_params[:countries])
    build_country_distances(trip, countries)
    if trip.save
      redirect_to(edit_trip_path(trip))
    else
      render :new
    end
  end

  def create_comment
    comment = Comment.new(comment_params)
    comment.trip_id = params[:id]
    comment.user_id = current_user.id
    if comment.save
      # TODO move this to a notification service
      notify_trip_owner_and_comment_authors(comment)
      flash[:success] = I18n.t('flash.trips.create_comment.comment_saved')
    else
      flash[:alert] = t('flash.trips.create_comment.alert')
    end
    redirect_to trip_path(comment.trip)
  end

  def update
    if trip.update_attributes(trip_params)
      respond_to do |wants|
        wants.html { redirect_to edit_trip_path(trip) }
        wants.js
      end
    else
      render action: 'edit'
    end
  end

  def destroy
    trip.destroy
    redirect_to user_path(current_user)
  end

  def add_ride
    trip = Trip.find(params[:id])
    trip.add_ride
    flash[:success] = I18n.t('flash.rides.add_ride.success')
    redirect_to edit_trip_path(trip.to_param)
  end

  private

  def authenticate_trip_owner
    if trip.user != current_user
      flash[:alert] = "This is not your trip."
      redirect_to trips_path
    end
  end

  def notify_trip_owner_and_comment_authors(comment)
    # notify all comment authors who are not the trip owner and not the comment author
    comment_authors = Comment.where(trip_id: comment.trip_id)
                             .where("user_id != #{comment.user.id}")
                             .where("user_id != #{comment.trip.user.id}")
                             .select('DISTINCT user_id')
                             .map(&:user)

    comment_authors.each do |author|
      CommentMailer.notify_comment_authors(comment, author).deliver_now
    end

    CommentMailer.notify_trip_owner(comment).deliver_now unless comment.user == comment.trip.user
  end

  def trip_in_context
    if params[:id]
      Trip.includes(:rides, :country_distances, user: [trips: [:rides, :country_distances]]).find(params[:id])
    else
      Trip.new(trip_params)
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: t('general.record_not_found')}
  end

  def trip_params
    if params[:trip]
      params.require(:trip).permit(
        :from,
        :to,
        :hitchhikes,
        :departure,
        :departure_time,
        :arrival,
        :arrival_time,
        :travelling_with,
        :route,
        :distance,
        :gmaps_duration,
        :countries,
        :from_lat,
        :from_lng,
        :from_formatted_address,
        :from_city,
        :from_country,
        :from_postal_code,
        :from_street,
        :from_street_no,
        :from_country_code,
        :to_lat,
        :to_lng,
        :to_formatted_address,
        :to_city,
        :to_country,
        :to_postal_code,
        :to_street, :to_street_no, :to_country_code
      )
    end
  end

  def comment_params
    params.permit(:body)
  end

  def trips_in_context
    trips = Trip
    unless params[:country].blank?
      trips = trips.includes(:country_distances).where(country_distances: {country: params[:country]})
    end
    unless params[:experience].blank?
      trips = trips.includes(:rides).where(rides: { experience: params[:experience] })
    end
    unless params[:gender].blank?
      trips = trips.joins(:user).where(users: { gender: params[:gender] })
    end
    if params[:hitchhiked_with]
      trips = trips.where(travelling_with: params[:hitchhiked_with])
    end
    if params[:stories]
      trips = trips.includes(:rides).where("rides.story IS NOT NULL AND rides.story != ''")
    end
    if params[:photos]
      trips = trips.includes(:rides).where("rides.photo != ''")
    end
    if params[:tag]
      trips = Trip.joins(rides: :tags).where(tags: {name: [params[:tag]]})
    end
    trips = trips.latest_first.paginate(page: params[:page])
  end

  def build_country_distances(trip, countries)
    # e.g. countries = [["Netherlands",116566],["Belgium",86072]]
    countries.each do |country_distance|
      trip.country_distances.build(country: country_distance[0],
                                   distance: country_distance[1],
                                   country_code: Countries[country_distance[0]])
    end
  end
end
