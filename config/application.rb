require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Hitchlog
  class Application < Rails::Application
    # Versions of your assets, change this line if you want to expire all your assets
    config.asset_version = '1.0'
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.initialize_on_precompile = false

    config.active_record.raise_in_transactional_callbacks = true

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    config.i18n.available_locales = %w(en de)
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
