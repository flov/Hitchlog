class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    user_path(current_user.to_s.downcase)
  end

  def build_search_trips(trips)
    unless params[:country].blank?
      @trips = @trips.includes(:country_distances).where(country_distances: {country: params[:country]})
    end
    unless params[:experience].blank?
      @trips = @trips.includes(:rides).where(rides: { experience: params[:experience] })
    end
    unless params[:gender].blank?
      @trips = @trips.joins(:user).where(users: { gender: params[:gender] })
    end
    if params[:hitchhiked_with]
      @trips = @trips.where(travelling_with: params[:hitchhiked_with])
    end
    if params[:stories]
      @trips = @trips.includes(:rides).where("rides.story IS NOT NULL AND rides.story != ''")
    end
    if params[:photos]
      @trips = @trips.includes(:rides).where("rides.photo_file_name IS NOT NULL")
    end
    @trips
  end
end
