Hitchlog::Application.configure do
  config.from_file 'hitchlog.yml'

  # Custom Attributes
  config.host = Rails.configuration.host
  config.facebook_id = Rails.configuration.facebook_id
  config.facebook_secret = Rails.configuration.facebook_secret
end
