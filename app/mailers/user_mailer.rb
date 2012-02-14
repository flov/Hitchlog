class UserMailer < ActionMailer::Base

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered", :from => "no-reply@hitchlog.com")
  end

  def mail_to_user(user, message, subject)
    @message = message
    mail(:to => user.email, :subject => subject, :from => user.email)
  end
end
