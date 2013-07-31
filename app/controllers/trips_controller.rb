class TripsController < ApplicationController
  expose!( :trip ) { trip_in_context }
  expose( :trips ) { trips_in_context }

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authenticate_trip_owner, only: [:edit, :update, :destroy]

  def create
    trip.user = current_user
    if trip.save
      redirect_to(edit_trip_path(trip))
    else
      render :new
    end
  end

  def create_comment
    comment = Comment.new(body: params[:body])
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

  def edit
    trip.rides.each do |ride|
      if ride.person.nil?
        ride.build_person
      end
    end
  end

  def update
    if trip.update_attributes(params[:trip])
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
    redirect_to trips_url
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
      CommentMailer.notify_comment_authors(comment, author).deliver
    end

    CommentMailer.notify_trip_owner(comment).deliver unless comment.user == comment.trip.user
  end

  def trip_in_context
    if params[:id]
      Trip.includes(:rides, :country_distances, user: [trips: [:rides, :country_distances]])
          .find(params[:id])
    else
      Trip.new(params[:trip])
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: t('general.record_not_found')}
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
    trips = trips.order("trips.id DESC").paginate(:page => params[:page])
  end
end
