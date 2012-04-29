class CommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_comment_authors(comment, author)
    @comment, @author, @trip = comment, author, comment.trip
    mail(:to => @author.email,
         :subject => "[Hitchlog] New Comment From #{@comment.user}",
         :from => 'no-reply@hitchlog.com')
  end

  def notify_trip_owner(comment)
    @trip, @comment = comment.trip, comment
    mail(:to => @trip.user.email,
         :subject => "[Hitchlog] New Comment From #{@comment.user}",
         :from => 'no-reply@hitchlog.com')
  end

  def notify_trip_owner_and_comment_authors(comment)
    # notify all comment authors who are not the trip owner and not the comment author
    comment_authors = Comment.where(trip_id: comment.trip_id)
                             .where("user_id != #{comment.user.id}")
                             .where("user_id != #{comment.trip.user.id}")
                             .select('DISTINCT user_id')
                             .map{|comment| comment.user}

    comment_authors.each do |author|
      notify_comment_authors(comment, author)
    end

    unless comment.user == comment.trip.user
      notify_trip_owner(comment)
    end
  end
end
