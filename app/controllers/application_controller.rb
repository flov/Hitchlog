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
end
