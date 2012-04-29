require "spec_helper"

describe CommentMailer do
  describe "#notify_comment_authors" do
    it "renders template" do
      @trip = Factory(:trip)
      @user = Factory(:user)
      @comment = Factory(:comment, user_id: @user)
      lambda { UserMailer.notify_comment_authors(@comment, @user) }.should_not raise_error
    end
  end

  describe "#notify_trip_owner_of_comment" do
    it "renders template" do
      @trip = Factory(:trip)
      @comment = Factory(:comment)
      lambda { UserMailer.notify_trip_owner_of_comment(@comment) }.should_not raise_error
    end
  end
end
