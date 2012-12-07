class HitchslideController < ApplicationController
  #def next
    #@ride = Ride.where('photo_file_name is not null')
                    #.where("id > #{params[:id].to_i}")
                    #.order(:id).first

    #if @ride.nil?
      #@ride = Ride.where('photo_file_name is not null').order(:id).first
    #end

    #respond_to do |format|
      #format.json { render "rides/show", formats: [:json] }
    #end
  #end

  #def prev
    #@ride = Ride.where('photo_file_name is not null')
                #.where("id < #{params[:id].to_i}")
                #.order(:id).last

    #if @ride.nil?
      #@ride = Ride.where('photo_file_name is not null').order(:id).last
    #end

    #respond_to do |format|
      #format.json { render "rides/show", formats: [:json] }
    #end
  #end

  def random
    respond_to do |format|
      format.json { render "rides/show", ride: random_photo_ride, formats: [:json] }
    end
  end
end
