require 'spec_helper'

describe "Hitchhikers" do
  describe "GET /hitchhikers" do
    it "should display some users and their details" do
      user1 = Factory :user
      user2 = Factory :user
      visit users_path
      page.find("#user_#{user1.id}").should have_content(user1.to_s)
      page.find("#user_#{user2.id}").should have_content(user2.to_s)
    end
  end
end
