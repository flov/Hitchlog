Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^(?:I am|I'm) logged in as (\w+)$/ do |username|
  if username == "alex"
    @user = Factory(:alex) 
  else
    @user = Factory(:user, :username => username)
  end

  visit path_to('the login page')
  fill_in('Username', :with => @user.username)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
  if defined?(Spec::Rails::Matchers)
    page.should have_content('devise.sessions.signed_in')
  else
    assert page.has_content?('Signed in successfully')
  end
end
