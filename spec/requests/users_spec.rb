require 'spec_helper'

describe "users" do
  before do
    @user = Factory(:user)
  end

  describe "GET /users/edit" do
    before do
      visit new_user_session_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      visit user_path(@user)
      click_link "Edit Profile"
    end

    xit "displays fields for editing profil" do
      page.should have_field     "About you" 
      page.should have_select    "Gender" 
      page.should have_field     "CS User" 
      page.should have_content   "Avatar" 
      page.should have_content   "Hitchlog only supports profile images through gravatar.com. If you want to upload your own image, please upload your own photo on gravatar.com." 
    end
  end
end
