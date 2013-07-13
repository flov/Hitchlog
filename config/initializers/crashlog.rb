CrashLog.configure do |config|
  config.api_key = ENV['CRASHLOG_KEY']
  config.secret =  ENV['CRASHLOG_SECRET']
end
