module AuthenticationsHelper
  def facebook_login
    link_to "Login with Facebook", "auth/facebook"
  end
end
