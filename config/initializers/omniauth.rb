Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Hitchlog::Application.config.facebook_id,
                      Hitchlog::Application.config.facebook_secret,
                      scope: 'email'
end
