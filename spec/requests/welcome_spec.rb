require 'spec_helper'

describe "Welcome Spec" do
  describe "GET /" do
    it "should display nearby hitchhikers" do
      user  = Factory :user
      visit new_user_session_path
      fill_in "Username", :with => user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      visit root_path
      page.should_not have_content 'Nearby hitchhikers'
    end
  end
end
