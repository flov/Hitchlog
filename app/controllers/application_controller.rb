class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.to_s.downcase)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email,
               :gender,
               :password,
               :password_confirmation,
               :remember_me,
               :username,
               :about_you,
               :cs_user,
               :be_welcome_user,
               :lat,
               :lng,
               :city,
               :location,
               :country,
               :country_code,
               :origin,
               :languages,
               :date_of_birth)
    end
  end
end
