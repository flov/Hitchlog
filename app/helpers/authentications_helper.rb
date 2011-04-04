module AuthenticationsHelper
  def facebook_authentication
    link_to "Sign up with Facebook", "/auth/facebook", :id => 'facebook_authentication'
  end

  def facebook_login
    link_to "Login with Facebook", "/auth/facebook", :id => 'facebook_login'
  end
end
