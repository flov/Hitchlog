# USERS:
When /^I search for "([^"]*)" by username$/ do |username|
  fill_in('q_username_cont', with: username)
  click_button('Search')
end

When /^I search for "([^"]*)" by location$/ do |location|
  fill_in('q_location_cont', with: location)
  click_button('Search')
end



# TRIPS:


When /^I search for trips with stories$/ do
  check "story"
  click_button "search"
end

When /^I search for "([^"]*)" trips$/ do |search_word|
  fill_in  "from", with: search_word
  click_button "search"
end

Then /^I should see a German trip$/ do
  page.should have_content @german_trip.from
end

Then /^I should see an English trip$/ do
  page.should have_content @english_trip.from
end

Then /^I should not see an English trip$/ do
  page.should_not have_content @english_trip.from
end
