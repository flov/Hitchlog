class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_trip_and_redirect_if_not_owner, :only => [:edit]

  expose( :trip )

  def new
  end

  def show
  end

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
      # TODO move this to comment model and append to after_create callback
      notify_trip_owner_and_comment_authors(comment)
      flash[:notice] = I18n.t('flash.trips.create_comment.comment_saved')
    else
      flash[:alert]  = t('flash.trips.create_comment.alert')
    end
    redirect_to trip_path(comment.trip)
  end

  def index
    @trips = Trip
    @trips = build_search_trips(@trips)
    @trips = @trips.order("trips.id DESC").paginate(:page => params[:page])
  end

  def edit
    @user = @trip.user
    @rides_with_photos = @trip.rides.select{|ride| ride.photo.file?}
    @rides = @user.trips.map{|trip| trip.rides}.flatten
    @trip.rides.each do |ride|
      if ride.person.nil?
        ride.build_person
      end
    end
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(params[:trip])
      respond_to do |wants|
        wants.html { redirect_to edit_trip_path(@trip) }
        wants.js {}
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_url
  end

  private

  def find_trip_and_redirect_if_not_owner
    @trip = Trip.find(params[:id])
    if @trip.user != current_user
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
                             .map{|comment| comment.user}

    comment_authors.each do |author|
      CommentMailer.notify_comment_authors(comment, author).deliver
    end

    unless comment.user == comment.trip.user
      CommentMailer.notify_trip_owner(comment).deliver
    end
  end
end
