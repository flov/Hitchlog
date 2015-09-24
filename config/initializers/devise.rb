Devise.setup do |config|
  require 'devise/orm/active_record'
  config.mailer_sender = "florian@hitchlog.com"
  config.secret_key = 'a7475c68cbd4a0048f6c0093ee93cac28551f1bc6013ec10b14854cb9cba3d5065e1223c5694694a385d34dfa4d56dd4144cf50459992fe756a0fec5e78516da'
  config.authentication_keys = [ :username ]
  config.pepper = "e61e2fa1aeb5895fbfbbb8c45bb282d9bda8f09dfeadc9afaeef950586b5bfd40b8414692524d494f66947d28e24a13f315a6d8b7c88194036c9e70d1dc52231"
  config.password_length = 4..20
  config.email_regexp = /\A[^@]+@[^@]+\z/

  config.case_insensitive_keys = [ :email, :username ]
  config.strip_whitespace_keys = [ :email, :username ]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
    scope: 'user_friends,user_birthday,email'
end
