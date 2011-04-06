Rails.application.config.middleware.use OmniAuth::Builder do  
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
  provider :facebook,
           Hitchlog::Application.config.facebook_id,
           Hitchlog::Application.config.facebook_secret,
           :scope => 'email,offline_access'
end  
