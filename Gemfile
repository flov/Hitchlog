source 'http://rubygems.org'

gem 'rake'

gem 'rails', '3.2.12'
gem 'mysql2',  '>=0.3'

gem 'decent_exposure'

gem 'devise', '1.4.5'
gem 'rdiscount' # Markdown
gem 'will_paginate', '~> 3.0.pre2'
gem 'nokogiri' # xml parser
gem 'crashlog', '~> 1.0.6'

gem 'ransack' # replacement for meta_search which isn't compatible with rails 3.1

gem 'geocoder'
gem 'paperclip'
gem 'haml', '~> 3.2.0.rc.4'

gem 'gravatar_image_tag'
gem 'escape_utils' # annoying UTF-8 warning with ruby 1.9.2
gem 'omniauth-facebook'

gem 'i18n_data'
gem 'choices' # external settings in Rails app
gem 'friendly_id', '~> 3.2.1'

gem 'simple_form'
gem 'compass'

gem 'json'
gem 'jbuilder'
gem 'routing-filter' # wraps I18n.locale around routing engine

gem 'jquery-rails', '3.0.1'
gem 'jquery-ui-rails'

gem 'thin'

group :production do
  gem 'newrelic_rpm'
end

# Gems only used for assets and not required by default
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass-rails'
end

gem "font-awesome-rails"

group :development do
  gem 'web_translate_it'
  gem 'hirb'
  gem 'capistrano-ext'
  gem 'capistrano'
  gem 'growl'
  gem 'guard'
  gem 'guard-zeus'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-bundler'
  gem 'guard-livereload'
end

group :test, :development do
  gem 'vcr'
  gem 'rspec-rails'
  gem 'launchy'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'pickle'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'factory_girl_generator'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'fakeweb'
  gem 'faker'
  gem 'email_spec'
  gem 'rb-fsevent'
end
