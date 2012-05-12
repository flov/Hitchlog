class CommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_comment_authors(comment, author)
    @comment, @author, @trip = comment, author, comment.trip
    mail(:to => @author.email,
         :subject => "[Hitchlog] New Comment On #{@trip} From #{@comment.user}",
         :from => 'no-reply@hitchlog.com')
  end

  def notify_trip_owner(comment)
    @trip, @comment = comment.trip, comment
    mail(:to => @trip.user.email,
         :subject => "[Hitchlog] New Comment On #{@trip} From #{@comment.user}",
         :from => 'no-reply@hitchlog.com')
  end
end
