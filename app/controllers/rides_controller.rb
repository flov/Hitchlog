class RidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:next, :prev, :random, :show, :index]

  expose :ride

  def show
  end

  def random
    @ride = Ride.where('photo_file_name is not null').order('RAND()').first
    respond_to do |format|
      format.json { render "rides/show", formats: [:json] }
    end
  end

  def next
    @ride = Ride.where('photo_file_name is not null')
                .where("id > #{params[:id].to_i}")
                .order(:id).first

    if @ride.nil?
      @ride = Ride.where('photo_file_name is not null').order(:id).first
    end

    respond_to do |format|
      format.json { render "rides/show", formats: [:json] }
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
