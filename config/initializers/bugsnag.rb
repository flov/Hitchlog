if ENV['BUGSNAG']
  Bugsnag.configure do |config|
    config.api_key = ENV['BUGSNAG']
  end
end
