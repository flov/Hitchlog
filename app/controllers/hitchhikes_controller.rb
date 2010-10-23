class HitchhikesController < ApplicationController
  def index
    @hitchhikes = Hitchhike.all
    # if params[:id]
    #   @hh = Hitchhike.find_by_id(params[:id])
    # else
    #   @hh = Hitchhike.find(:first, :order => 'RANDOM()')
    # end

    respond_to do |wants|
      wants.html { }
      # wants.json { render :json => @hh.build_hash.to_json }
    end
  end

  def inspiration
  end

  def show
    @hitchhike = Hitchhike.find(params[:id])
  end
  
  def new
    @hitchhike = Hitchhike.new
    # @hitchhike.people.build
  end
  
  def create
    @hitchhike = Hitchhike.new(params[:hitchhike])
    if @hitchhike.save
      # if params[:hitchhike][:photo].blank?
        flash[:notice] = "Successfully created hitchhike."
        redirect_to @hitchhike
      # else
      #   render :action => "crop"
      # end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @hitchhike = Hitchhike.find(params[:id])
  end
  
  def update
    @hitchhike = Hitchhike.find(params[:id])
    if @hitchhike.update_attributes(params[:hitchhike])
      if params[:hitchhike][:photo].blank?
        flash[:notice] = "Successfully updated hitchhike."
        redirect_to @hitchhike
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
    redirect_to hitchhikes_url
  end
end
