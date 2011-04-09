class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # render :text => env["omniauth.auth"].to_yaml

    @user = User.find_for_facebook_oauth(env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to new_user_registration_url
    end
  end

  def index  
    @authentications = current_user.authentications if current_user  
  end  
    
  def destroy  
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    flash[:notice] = "Successfully destroyed authentication."  
    redirect_to authentications_url  
  end  
end
