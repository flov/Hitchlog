Devise.setup do |config|
  require 'devise/orm/active_record'
  config.mailer_sender = "florian@hitchlog.com"
  config.authentication_keys = [ :username ]
  config.pepper = "e61e2fa1aeb5895fbfbbb8c45bb282d9bda8f09dfeadc9afaeef950586b5bfd40b8414692524d494f66947d28e24a13f315a6d8b7c88194036c9e70d1dc52231"
  config.secret_key = 'e9e39eb9e91b52cf02cd190e61a144e6341be769d97fb4bf3d0648003d0246b665a11c59ef3696be67f8168afcb5b3f74c6567807e9924f828a258f4b507c681'
  config.password_length = 4..20
  config.email_regexp = /\A[^@]+@[^@]+\z/

  config.case_insensitive_keys = [ :email, :username ]
  config.strip_whitespace_keys = [ :email, :username ]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = false

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
  config.skip_session_storage = [:http_auth]
  config.expire_all_remember_me_on_sign_out = true

  config.omniauth :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
    scope: 'user_birthday,user_gender,email'
end
