require 'cucumber/rails'
require 'email_spec/cucumber'

Capybara.default_selector = :css

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

I18n.backend.reload!
FactoryGirl.reload
