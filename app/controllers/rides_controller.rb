class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:next, :prev, :show, :index]

  expose( :ride )

  def create
    ride.trip = Trip.find(params[:trip_id])
    if ride.save
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(ride.trip)
      else
        render action: "crop"
      end
    else
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def delete_photo
    if ride.delete_photo!
      redirect_to edit_trip_path(ride.trip)
    else
      flash[:alert] = 'Could not delete photo'
      render :edit
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def update
    if ride.update_attributes(params[:ride])
      if params[:ride][:photo].blank?
        redirect_to edit_trip_path(ride.trip)
      else
        render action: "crop"
      end
    else
      redirect_to edit_trip_path(ride.trip)
    end
  end

  def destroy
    if ride.trip.user == current_user
      ride.destroy
      flash[:success] = "Successfully destroyed ride."
    else
      flash[:alert] = "You are not allowed to do that!"
    end
    redirect_to edit_trip_path(ride.trip)
  end

  def next
    @ride = Ride.where('photo_file_name is not null')
                .where("id > #{params[:id].to_i}")
                .order(:id).first

    if @ride.nil?
      @ride = Ride.where('photo_file_name is not null').order(:id).first
    end

    respond_to do |format|
      format.json { render "rides/show", formats: [:json]}
    end
  end

  def prev
    @ride = Ride.where('photo_file_name is not null')
                .where("id < #{params[:id].to_i}")
                .order(:id).last

    if @ride.nil?
      @ride = Ride.where('photo_file_name is not null').order(:id).last
    end

    respond_to do |format|
      format.json { render "rides/show", formats: [:json] }
    end
  end
end
