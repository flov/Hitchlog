Hitchlog::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = true

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'test.host' }

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  config.assets.allow_debugging = true

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {
    :provider => 'facebook',
    :uid => '10206267250652792',
    :info => {
      :email => "florian@hitchlog.com",
      :first_name => "Florian",
      :image => "http://graph.facebook.com/10206267250652792/picture",
      :last_name => "Vallen",
      :name => "Florian Vallen",
      :urls => { :Facebook => "https://www.facebook.com/app_scoped_user_id/10206267250652792/" },
    },
    :credentials => {
      :token => 'ABCDEF',
      :expires_at => 1446642385,
      :expires => true
    },
    :extra => {
      :raw_info => {
        :birthday => "08/16/1986",
        :email => "florian.vallen@gmail.com",
        :first_name => "Florian",
        :gender => "male",
        :id => "10206267250652792",
        :last_name => "Vallen",
        :link => "https://www.facebook.com/app_scoped_user_id/10206267250652792/",
        :locale => "en_US",
        :name => "Florian Vallen",
        :timezone => 2,
        :updated_time => "2015-07-19T11:39:24+0000",
        :verified => true
      }
    }
  })
end
