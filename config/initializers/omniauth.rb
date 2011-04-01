Rails.application.config.middleware.use OmniAuth::Builder do  
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
  provider :facebook, 'bc52bf6b4ea8fa42df28d66569e840d7', 'f2bd94d90abef946d0f4fa70a1ebfbdc', scope => 'email,offline_access'
end  
