Hitchlog::Application.configure do
  config.cache_classes = true

  config.force_ssl = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # Disable delivery errors, bad email addresses will be ignored
  config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  config.serve_static_files = true

  config.assets.compress = true
  config.assets.js_compressor = :uglifier
  config.eager_load = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false
  # Generate digests for assets URLs.
  config.assets.digest = true

  config.secret_key = '26338d643aa9aeb67fb5c859108153e64b460ab1a17df73c9207ceaefcd15eac6ac7069e2b57bc996e875ca810e7b5e6780d45f622cbbb53003cd9fb9f72d823'

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( *.js )

  config.action_mailer.default_url_options = { :host => 'hitchlog.com' }
  config.action_mailer.delivery_method = :smtp
  config.after_initialize do
    ActionMailer::Base.smtp_settings = {
      :address => ENV['SMTP_ADDRESS'],
      :domain => ENV['SMTP_DOMAIN'],
      :port => ENV['SMTP_PORT'],
      :user_name => ENV['SMTP_USER'],
      :password => ENV['SMTP_PASS'],
      :authentication  => :plain,
      :enable_starttls_auto => true
    }
  end
end
