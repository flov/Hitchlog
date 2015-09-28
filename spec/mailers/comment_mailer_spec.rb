require "rails_helper"

RSpec.describe CommentMailer do
  describe "#notify_comment_authors" do
    it "renders template" do
      @trip = FactoryGirl.create(:trip)
      @user = FactoryGirl.create(:user)
      @comment = FactoryGirl.create(:comment, user_id: @user.id, trip_id: @trip.id)
      expect { CommentMailer.notify_comment_authors(@comment, @user) }.not_to raise_error
    end
  end

  describe "#notify_trip_owner" do
    it "renders template" do
      @trip = FactoryGirl.create(:trip)
      @comment = FactoryGirl.create(:comment)
      expect { CommentMailer.notify_trip_owner(@comment) }.not_to raise_error
    end
  end
end
