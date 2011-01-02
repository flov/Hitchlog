class HitchhikesController < ApplicationController
  before_filter :authenticate_user!, :except => [:json, :show, :index]

  def json
    if params[:id]
      render :json => Hitchhike.find(params[:id]).to_json
    else
      render :json => Hitchhike.random_item.to_json
    end
  end

  def show
    @hitchhike = Hitchhike.find(params[:id])
    respond_to do |wants|
      wants.html
      wants.json { render :json => @hitchhike.to_json }
    end
  end

  def create
    @hitchhike = Hitchhike.new(params[:hitchhike])
    @hitchhike.trip = Trip.find(params[:trip_id])
    if @hitchhike.save
      if params[:hitchhike][:photo].blank?
        flash[:notice] = "Thanks for creating a new hitchhike."
        redirect_to trips_path
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @hitchhike = Hitchhike.find(params[:id])
    @hitchhike.build_person
    @trip      = @hitchhike.trip
  end
  
  def update
    @hitchhike = Hitchhike.find(params[:id])
    if @hitchhike.update_attributes(params[:hitchhike])
      if params[:hitchhike][:photo].blank?
        flash[:notice] = "Successfully updated hitchhike."
        redirect_to trips_path
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @hitchhike = Hitchhike.find(params[:id])
    if @hitchhike.trip.user == current_user
      @hitchhike.destroy
      flash[:notice] = "Successfully destroyed hitchhike."
    else
      flash[:error] = "You are not allowed to do that!"
    end
    redirect_to trips_url
  end
end