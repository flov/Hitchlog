require "rails_helper"

RSpec.describe UserMailer do
  describe "#registration_confirmation" do
    it "renders template" do
      @user = FactoryBot.create :user
      expect { UserMailer.registration_confirmation(@user) }.not_to raise_error
    end
  end

  describe "#mail_to_user" do
    it "renders template" do
      @user = FactoryBot.create(:user)
      @from_user = FactoryBot.create(:user)
      expect { UserMailer.mail_to_user(@from_user, @user, "test message") }.not_to raise_error
    end
  end
end
