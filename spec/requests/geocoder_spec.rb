require 'spec_helper'

describe "Nearby Hitchhikers" do
  describe "Sign in and see nearby hitchhikers" do
    it "should not display nearby hitchhikers" do
      user   = Factory :user
      user2  = Factory :user
      visit new_user_session_path
      fill_in "Username", :with => user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      page.should have_content 'Nearby hitchhikers'
      visit root_path
      page.should have_content 'Nearby hitchhikers'
    end
  end
end

