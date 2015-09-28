# set local environmets
require "#{Rails.root}/.env.rb" if File.exists?("#{Rails.root}/.env.rb")

Hitchlog::Application.configure do
  config.eager_load = false

  config.cache_classes = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # serve all files or put all of them into one file:
  config.assets.debug = true

  config.action_mailer.raise_delivery_errors = false
	config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => 'hitchlog.dev' }

  config.after_initialize do
    config.action_mailer.smtp_settings = {
      :user_name => ENV['MAILTRAP_USER'],
      :password =>  ENV['MAILTRAP_PASSWORD'],
      :address =>   ENV['MAILTRAP_HOST'],
      :port =>      ENV['MAILTRAP_PORT'],
      :authentication => :plain
    }
  end
end

