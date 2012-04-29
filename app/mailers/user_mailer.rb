class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    mail(:to => user.email,
         :subject => "[Hitchlog] Welcome aboard",
         :from => "no-reply@hitchlog.com")
  end

  def mail_to_user(from_user, to_user, message)
    @message, @to_user, @from_user = message, to_user, from_user
    mail(:to => to_user.email,
         :subject => "[Hitchlog] New Message From #{from_user}",
         :from => from_user.email)
  end
end
