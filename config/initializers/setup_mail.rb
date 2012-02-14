ActionMailer::Base.smtp_settings = {
  :address              => Rails.configuration.smtp_settings[:address],
  :port                 => Rails.configuration.smtp_settings[:port],
  :domain               => Rails.configuration.smtp_settings[:domain],
  :user_name            => Rails.configuration.smtp_settings[:user_name],
  :password             => Rails.configuration.smtp_settings[:password],
  :authentication       => Rails.configuration.smtp_settings[:authentication],
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = Rails.configuration.host
