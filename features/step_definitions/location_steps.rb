When /^I enter a new location "([^"]*)"$/ do |location|
  fill_in "Location", with: location
  find(".ui-autocomplete .ui-corner-all").click
end

Then /^"([^"]*)" should have "([^"]*)" as city$/ do |username, city|
  User.find_by_username(username).city.should == city
end

Then /^"([^"]*)" should have the lat and lng from Melbourne$/ do |username|
  user = User.find_by_username(username)
  user.lat.should == -37.8141
  user.lng.should == 144.963
end
