if ENV['MAILTRAP_HOST'].present?
  ActionMailer::Base.smtp_settings = {
    user_name:      ENV['MAILTRAP_USER_NAME'],
    password:       ENV['MAILTRAP_PASSWORD'],
    address:        ENV['MAILTRAP_HOST'],
    port:           ENV['MAILTRAP_PORT'],
    authentication: :plain
  }
else
  ActionMailer::Base.smtp_settings = {
    :address              => ENV['SMTP_DOMAIN'],
    :port                 => ENV['SMTP_ADDRESS'],
    :domain               => ENV['SMTP_DOMAIN'],
    :user_name            => ENV['SMTP_USER'],
    :password             => ENV['SMTP_PASS'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }
end

ActionMailer::Base.default_url_options[:host] = ENV['HOST']
