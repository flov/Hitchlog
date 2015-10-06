Hitchlog::Application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"


  config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
  config.serve_static_assets = true

  config.assets.compress = true
  config.assets.js_compressor = :uglifier
  config.eager_load = true

  config.assets.compile = false
  config.assets.digest = true
  config.assets.precompile += %w( *.js )

  config.action_mailer.default_url_options = { host: 'staging.hitchlog.com' }
  config.action_mailer.delivery_method = :smtp

  config.after_initialize do
    ActionMailer::Base.smtp_settings = {
      :address =>   ENV['MAILTRAP_HOST'],
      :port =>      ENV['MAILTRAP_PORT'],
      :user_name => ENV['MAILTRAP_USER'],
      :password =>  ENV['MAILTRAP_PASSWORD'],
      :authentication  => :plain,
    }
  end
end

