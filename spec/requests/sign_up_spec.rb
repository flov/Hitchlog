require 'spec_helper'

describe "Sign up Process" do
  describe "GET /users/sign_up" do
    it "should sign a user up" do
      visit new_user_registration_path
      fill_in "Username", :with => 'flov'
      fill_in "Email", :with => 'flov@hitchlog.com'
      fill_in "Password", :with => 'password'
      fill_in "Password confirmation", :with => 'password'
      select  "male", :from => "Gender"
      click_button "Sign up"
      page.should have_content 'Welcome aboard!'
      current_path.should == '/hitchhikers/flov'
      user = User.find_by_username 'flov'
      user.sign_in_address.should_not be_nil
    end
  end
end
