class AuthenticationsController < ApplicationController  
  def index  
    @authentications = current_user.authentications if current_user  
  end  
    
  def create  
    #render :text => request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'],
                                                             omniauth['uid'])  
    if authentication
      flash[:notice] = I18n.t('devise.sessions.signed_in')
      sign_in_and_redirect(:user, authentication.user)  
    elsif current_user  
      current_user.authentications.create(:provider => omniauth['provider'],
                                          :uid => omniauth['uid']) 
      flash[:notice] = "Authentication successful." 
      redirect_to authentications_url 
    else  
      user = User.new(:username => omniauth['extra']['user_hash']['username'],
                      :email => omniauth['user_info']['email'])
      user.authentications.build(:provider => omniauth['provider'],
                                 :uid => omniauth['uid'],
                                 :custom_attributes => omniauth)
      user.save
      sign_in_and_redirect(:user, user)
    end  
  end  
    
  def destroy  
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    flash[:notice] = "Successfully destroyed authentication."  
    redirect_to authentications_url  
  end  
end  

