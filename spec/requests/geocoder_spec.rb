require 'spec_helper'

describe "Nearby Hitchhikers" do
  # describe "Sign in and see nearby hitchhikers" do
  #   it "should display nearby hitchhikers" do
  #     user   = Factory :user
  #     user2  = Factory :user
  #     visit new_user_session_path
  #     fill_in "Username", :with => user.username
  #     fill_in "Password", :with => 'password'
  #     click_button "Sign in"
  #     page.should have_content 'Nearby hitchhikers'
  #     visit root_path
  #     page.should have_content 'Nearby hitchhikers'
  #   end
  # end

  describe "last login" do
    it "should dissplay nnew last signed in address" do
      user   = Factory :berlin_user
      visit new_user_session_path
      fill_in "Username", :with => user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      # save_and_open_page
      visit users_path
    end
  end
end

