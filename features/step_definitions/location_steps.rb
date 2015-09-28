When /^I enter a new location "([^"]*)"$/ do |location|
  fill_in('Location', with: location, exact: true)
  page.find(:css, ".pac-container .pac-item", match: :first).click
end

Then /^"([^"]*)" should have "([^"]*)" as city$/ do |username, city|
  expect(User.find_by_username(username).city).to eq(city)
end

Then /^"([^"]*)" should have the lat and lng from Melbourne$/ do |username|
  user = User.find_by_username(username)
  expect(user.lat).to eq(-37.8142155)
  expect(user.lng).to eq(144.9632307)
end

Then /^on the profile page of "([^"]*)" I should see that he is currently in "([^"]*)"$/ do |username, location|
  user = User.find_by_username(username)
  visit(user_path(user))
  expect(page).to have_content( location )
end
