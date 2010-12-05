class HitchhikesController < ApplicationController
  before_filter :authenticate_user!, :except => [:json, :show, :index]

  def json
    if params[:id]
      render :json => Hitchhike.find(params[:id]).to_json
    else
      render :json => Hitchhike.order('RAND()').first.to_json
    end
  end

  def show
    @hitchhike = Hitchhike.find(params[:id])
    respond_to do |wants|
      wants.html
      wants.json { render :json => @hitchhike.to_json }
    end
  end
  
  def new
    @hitchhike = Hitchhike.new
    @hitchhike.build_person
    @trip = Trip.find(params[:trip_id])
  end

  def create
    @hitchhike = Hitchhike.new(params[:hitchhike])
    @hitchhike.trip = Trip.find(params[:trip_id])
    @hitchhike.user = current_user
    if @hitchhike.save
      if params[:hitchhike][:photo].blank?
        flash[:notice] = "Successfully created hitchhike."
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
    @trip      = Trip.find(params[:trip_id])
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
    @hitchhike.destroy
    flash[:notice] = "Successfully destroyed hitchhike."
    redirect_to trips_url
  end
end