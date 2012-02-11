class UserMailer < ActionMailer::Base
  default :from => "no-reply@hitchlog.com"
  
  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered")
  end
end
