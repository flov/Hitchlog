class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:random_photo, :show, :index]

  def show
    @ride = Ride.find(params[:id])
  end

  def random_photo
    if params[:id] and params[:next]
      @ride = Ride.where('photo_file_name is not null')
                  .where("id > #{params[:id]}")
                  .order(:id).first
    elsif params[:id] and params[:prev]
      @ride = Ride.where('photo_file_name is not null')
                  .where("id < #{params[:id]}")
                  .order(:id).last
    else
      @ride = Ride.where('photo_file_name is not null').order('RAND()').first
    end
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
      flash[:alert] = "You are not allowed to do that!"
    end
    redirect_to edit_trip_path(@ride.trip)
  end
end
