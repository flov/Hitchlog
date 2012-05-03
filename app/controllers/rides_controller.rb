class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:random_photo, :show, :index]

  def show
    @ride = Ride.find(params[:id])
  end

  def random_photo
    if params[:id]
      @ride = Ride.find(params[:id])
    else
      @ride = Ride.where('photo_file_name is not null').sample
    end
    #respond_to do |format|
      #format.json { render json: @ride.as_json(only: [:photo_file_name, :experience, :title], include: [trip: {only: [:id, :from]}]) }
    #end
  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.trip = Trip.find(params[:trip_id])
    if @ride.save
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(@ride.trip)
      else
        render :action => "crop"
      end
    else
      redirect_to edit_trip_path(@ride.trip)
    end
  end

  def delete_photo
    @ride = Ride.find(params[:id])  
    if @ride.delete_photo!
      redirect_to edit_trip_path(@ride.trip)
    else
      flash[:alert] = 'Could not delete photo'
      render :edit
    end
  end
  
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(params[:ride])
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(@ride.trip)
      else
        render :action => "crop"
      end
    else
      redirect_to edit_trip_path(@ride.trip)
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    if @ride.trip.user == current_user
      @ride.destroy
      flash[:notice] = "Successfully destroyed ride."
    else
      flash[:error] = "You are not allowed to do that!"
    end
    redirect_to edit_trip_path(@ride.trip)
  end
end
