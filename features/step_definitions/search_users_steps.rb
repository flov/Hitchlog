When /^I search for "([^"]*)" by username$/ do |username|
  fill_in('q_username_cont', with: username)
  click_button('Search')
end

When /^I search for "([^"]*)" by location$/ do |location|
  fill_in('q_location_cont', with: location)
  click_button('Search')
end
