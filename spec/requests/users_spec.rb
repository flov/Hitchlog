require 'spec_helper'

describe "users" do
  before do
    @user = Factory(:user)
  end

  describe "GET /users/show" do
    before do
      visit user_path(@user)
    end

    it do
      page.should have_content "CS User: #{@user.cs_user}"
    end
  end

  describe "GET /users/edit" do
    context "logged in" do
      before do
        visit new_user_session_path
        fill_in "Username", :with => @user.username
        fill_in "Password", :with => 'password'
        click_button "Sign in"
        visit user_path(@user)
        click_link "Edit"
      end

      it "displays fields for editing profil" do
        fill_in "About you", :with => 'Hello everyone!'
        select  "Female", :from => "Gender"
        fill_in "CS user", :with => "flov"
        page.should have_content   "Avatar"
        page.should have_content   "Hitchlog only supports avatars through Gravatar."
        click_button "Update User"
      end
    end

    context "logged out" do
      it "should not see Edit Profile" do
        visit user_path(@user)
        page.should_not have_content  "Edit Profile" 
      end
    end
  end
end
