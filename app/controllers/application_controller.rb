class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.to_s.downcase)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def build_search_trips(trips)
    unless params[:country].blank?
      trips = trips.includes(:country_distances).where(country_distances: {country: params[:country]})
    end
    unless params[:experience].blank?
      trips = trips.includes(:rides).where(rides: { experience: params[:experience] })
    end
    unless params[:gender].blank?
      trips = trips.joins(:user).where(users: { gender: params[:gender] })
    end
    if params[:hitchhiked_with]
      trips = trips.where(travelling_with: params[:hitchhiked_with])
    end
    if params[:stories]
      trips = trips.includes(:rides).where("rides.story IS NOT NULL AND rides.story != ''")
    end
    if params[:photos]
      trips = trips.includes(:rides).where("rides.photo != ''")
    end
    trips
  end
end
