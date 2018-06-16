class OmniauthController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth( request.env["omniauth.auth"] )

    if user.persisted?
      if user.created_at > 1.minute.ago
        flash[:success] = t('flash.facebook_first_sign_up')
      else
        flash[:success] = t('devise.sessions.signed_in')
      end
      sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    else
      flash[:alert] = t('flash.error')
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_url
    end
  end
end
