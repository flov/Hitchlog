class OmniauthController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:alert] = t('flash.error')
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_url
    end
  end
end
