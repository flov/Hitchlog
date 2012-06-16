require "spec_helper"

describe CommentMailer do
  describe "#notify_comment_authors" do
    it "renders template" do
      @trip = FactoryGirl.create(:trip)
      @user = FactoryGirl.create(:user)
      @comment = FactoryGirl.create(:comment, user_id: @user.id, trip_id: @trip.id)
      lambda { CommentMailer.notify_comment_authors(@comment, @user) }.should_not raise_error
    end
  end

  describe "#notify_trip_owner" do
    it "renders template" do
      @trip = FactoryGirl.create(:trip)
      @comment = FactoryGirl.create(:comment)
      lambda { CommentMailer.notify_trip_owner(@comment) }.should_not raise_error
    end
  end
end
