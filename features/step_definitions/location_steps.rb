When /^I enter a new location "([^"]*)"$/ do |location|
  VCR.use_cassette 'edit_location' do
    fill_in('Location', with: location, exact: true)
    page.find(".pac-container .pac-item:first").click
  end
end

Then /^"([^"]*)" should have "([^"]*)" as city$/ do |username, city|
  User.find_by_username(username).city.should == city
end

Then /^"([^"]*)" should have the lat and lng from Melbourne$/ do |username|
  user = User.find_by_username(username)
  user.lat.should == -37.8142155
  user.lng.should == 144.9632307
end

Then /^on the profile page of "([^"]*)" I should see that he is currently in "([^"]*)"$/ do |username, location|
  user = User.find_by_username(username)
  visit(user_path(user))
  page.should have_content( "Current location: #{location}" )
end
