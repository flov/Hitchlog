Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^(?:I am|I'm) logged in as (\w+)$/ do |username|
  @user = Factory(:flov)  

  visit path_to('the login page')
  fill_in('Username', :with => @user.username)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
  if defined?(Spec::Rails::Matchers)
    page.should have_content('Signed in successfully')
  else
    assert page.has_content?('Signed in successfully')
  end
end