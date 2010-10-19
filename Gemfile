source 'http://rubygems.org'

gem 'rails', '3.0.0'
gem 'devise'
gem 'mysql'
gem 'haml', '~> 3.0.21'
gem 'nokogiri'
gem 'paperclip', '2.3.4'
gem 'aws-s3', :require => 'aws/s3'

gem "escape_utils" # annoying UTF-8 warning with ruby 1.9.2

# gem 'hpricot' # only for generating devise views
# gem 'ruby_parser' # only for generating devise views

group :development, :test, :cucumber do
  gem "rspec-rails"
end

group :test, :cucumber do
  gem 'cucumber', '0.9.2'
  gem 'cucumber-rails', '0.3.2'
  gem "factory_girl_rails"
  gem "capybara"
  gem "nokogiri"
  gem "shoulda"
  # gem "database_cleaner"
  # gem "fakeweb"
  # gem "timecop"
  # gem "treetop"
  # gem "launchy"
end
