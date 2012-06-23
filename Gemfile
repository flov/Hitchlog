source 'http://rubygems.org'

gem 'rake'

gem 'rails', '3.2.6'
gem 'sqlite3'
gem 'mysql2',  '>=0.3'

gem 'devise', '1.4.5'
gem 'rdiscount' # Markdown
gem 'will_paginate', '~> 3.0.pre2'
gem 'nokogiri' # xml parser
gem 'hoptoad_notifier'

gem 'ransack' # replacement for meta_search which isn't compatible with rails 3.1

gem 'geocoder'
gem 'paperclip'
gem 'haml', '~> 3.1.4'

gem 'gravatar_image_tag'
gem 'escape_utils' # annoying UTF-8 warning with ruby 1.9.2
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'i18n_data'
gem 'choices' # external settings in Rails app
gem 'friendly_id', '~> 3.2.1'

gem 'compass'

gem 'json'
gem 'jbuilder'
gem 'routing-filter' # wraps I18n.locale around routing engine

# Gems only used for assets and not required by default
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

group :development do
  gem 'thin' # use thin web-server instead of webrick
  gem 'hirb'
  gem 'capistrano-ext'
  gem 'capistrano'
  gem 'growl'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'livereload'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'launchy', '~> 2.0.5' # to use save_and_open_page
  gem 'pickle'
end

group :test do
  gem 'database_cleaner'
  gem 'spork', '0.9.0.rc9'
  gem 'factory_girl_rails'
  gem 'factory_girl_generator'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'faker'
  gem 'email_spec'
  gem 'rb-fsevent'
end
