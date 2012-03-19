require "spec_helper"

describe UserMailer do
  before do
    @user = Factory :user
  end

  describe "registration_confirmation"

  describe "mail_to_user" do
    it "renders mail_to_user template" do
      lambda { UserMailer.registration_confirmation(@user) }.should_not raise_error
    end

    it "renders mail_to_user template" do
      from_user = Factory(:user)
      lambda { UserMailer.mail_to_user(from_user, @user, "test message") }.should_not raise_error
    end
  end
end
