require "spec_helper"

describe UserMailer do
  describe "#registration_confirmation" do
    it "renders template" do
      @user = FactoryGirl.create :user
      lambda { UserMailer.registration_confirmation(@user) }.should_not raise_error
    end
  end

  describe "#mail_to_user" do
    it "renders template" do
      @user = FactoryGirl.create(:user)
      @from_user = FactoryGirl.create(:user)
      lambda { UserMailer.mail_to_user(@from_user, @user, "test message") }.should_not raise_error
    end
  end
end
