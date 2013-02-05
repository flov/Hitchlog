class HitchslideController < ApplicationController
  def random
    respond_to do |format|
      format.json { render "rides/show", ride: random_photo_ride, formats: [:json] }
    end
  end
end
