require 'spec_helper'

describe "Nearby Hitchhikers" do
  describe "Sign in and see nearby hitchhikers" do
    xit "should display nearby hitchhikers if there are some" do
      user1  = Factory(:user)
      user2  = Factory(:user)
      visit new_user_session_path
      fill_in "Username", :with => user1.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      visit root_path
      page.should have_content 'Nearby hitchhikers'
    end

    it "should not display nearby hitchhikers if there are none" do
      user   = Factory :user
      user2  = Factory :user
      visit new_user_session_path
      fill_in "Username", :with => user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      visit root_path
      page.should_not have_content 'Nearby hitchhikers'
    end
  end
end

