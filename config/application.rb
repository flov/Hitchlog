require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module Hitchlog
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Versions of your assets, change this line if you want to expire all your assets
    config.asset_version = '1.0'
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.initialize_on_precompile = false

    config.active_record.whitelist_attributes = false
    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    config.i18n.available_locales = %w(en pt fr de)
    config.i18n.default_locale = :en

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.template_engine :haml
    end

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
