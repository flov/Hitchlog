module OmniauthHelper
  def facebook_authentication
    link_to t('general.sign_up_with_facebook'), user_facebook_omniauth_authorize_path, class: 'pretty_button'
  end

  def facebook_login
    link_to t('general.sign_in_with_facebook'), user_facebook_omniauth_authorize_path, class: 'pretty_button'
  end
end
