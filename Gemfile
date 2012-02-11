source 'http://rubygems.org'

gem 'rake', '0.9.2'

gem 'rails', '3.2.0'
gem 'sqlite3'
gem 'mysql2',  '>=0.3'

gem 'devise', '1.4.5'
gem 'rdiscount'
gem 'will_paginate', '~> 3.0.pre2'
gem 'hirb'
gem 'nokogiri'
gem 'hoptoad_notifier'

# gem 'meta_where'
# gem "meta_search"
gem "ransack"  # replacement for meta_search which isn't compatible with rails 3.1

gem 'geocoder'

gem 'paperclip'

gem 'jammit'
gem 'mongrel'
gem 'json'
gem 'aws-s3', :require => 'aws/s3'
gem 'hpricot'

gem 'compass'
gem 'haml', '~> 3.1.4'
gem 'compass-colors'
gem 'fancy-buttons'

gem 'gravatar_image_tag'
gem 'escape_utils' # annoying UTF-8 warning with ruby 1.9.2
# gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git', :branch => 'rails-3.0'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'i18n_data'
gem 'friendly_id', '~> 3.2.1'

# external settings in Rails app
gem 'choices'

# coffeescript
gem 'barista', '~> 1.0'

group :development do
  gem 'capistrano-ext'
  gem 'capistrano'
end

group :test, :development do
  gem "rspec-rails"
  gem 'launchy', '~> 2.0.5' # to use save_and_open_page
end

group :test do
  gem 'spork', '0.9.0.rc9'

  gem 'guard'
  gem "guard-livereload"
  gem "guard-rspec"
  gem 'guard-bundler'
  gem 'guard-spork'

  gem 'database_cleaner'

  gem "factory_girl_rails"
  gem 'factory_girl_generator'

  gem 'shoulda'
  gem "capybara"

  # growl notifications (doesn't work yet with growl 1.3, hmpf)
  gem 'growl_notify'
  gem 'rb-fsevent'

  gem 'nokogiri'
  gem 'livereload'
  gem 'faker'
end
