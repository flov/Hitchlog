module OmniauthHelper
  def facebook_authentication
    #link_to "Sign up with Facebook", "/auth/facebook", :id => 'facebook_authentication'
    link_to "Sign up with Facebook", user_omniauth_authorize_path(:facebook), :id => 'facebook_authentication'
  end

  def facebook_button
    #link_to "Sign up with Facebook", "/auth/facebook", :id => 'facebook_authentication'
    link_to "Sign up with Facebook", user_omniauth_authorize_path(:facebook), :id => 'facebook_button'
  end
  
  def facebook_login
    #link_to "Login with Facebook", "/auth/facebook", :id => 'facebook_login'
    link_to "Login with Facebook", user_omniauth_authorize_path(:facebook), :id => 'facebook_authentication'
  end
end
