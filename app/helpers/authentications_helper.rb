module AuthenticationsHelper
  def facebook_login
    link_to image_tag("authbuttons/png/facebook_signup.png"), "/auth/facebook"
  end
end
