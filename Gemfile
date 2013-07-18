source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'pg'
gem 'unicorn'

group :assets do
  gem 'jquery-rails', '3.0.1'
  gem 'jquery-ui-rails'
  gem 'sass-rails', '~> 3.2'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass-rails'
end

gem 'decent_exposure'
gem 'devise', '1.5.3'
gem 'rdiscount' # Markdown
gem 'will_paginate', '~> 3.0.pre2'
gem 'nokogiri' # xml parser
gem 'crashlog', '~> 1.0.6'
gem 'ransack' # replacement for meta_search which isn't compatible with rails 3.1
gem 'geocoder'
gem 'haml', '~> 3.2.0.rc.4'
gem 'omniauth-facebook'
gem 'friendly_id', '~> 3.2.1'
gem 'simple_form'
gem 'compass'

gem 'carrierwave'
gem 'fog'
gem 'rmagick'

gem 'escape_utils' # annoying UTF-8 warning with ruby 1.9.2
gem 'i18n_data'
gem 'i18n-tasks'
gem 'gravatar_image_tag'

gem 'json'
gem 'routing-filter' # wraps I18n.locale around routing engine

group :production do
  gem 'newrelic_rpm'
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
  gem 'guard-jasmine'
end

group :test, :development do
  gem 'vcr'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'jasmine-rails'
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
