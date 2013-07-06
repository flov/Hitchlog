ActionMailer::Base.smtp_settings = {
  :address              => ENV['SMTP_DOMAIN'],
  :port                 => ENV['SMTP_ADDRESS'],
  :domain               => ENV['SMTP_DOMAIN'],
  :user_name            => ENV['SMTP_USER'],
  :password             => ENV['SMTP_PASS'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = Rails.configuration.host
