When /^I fill in the future trip form with from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |from, to, departure|
  date = Date.parse departure

  fill_in('future_trip_from', with: from, exact: true)
  page.find(:css, ".pac-container .pac-item", match: :first).click

  fill_in('future_trip_to', with: to, exact: true)
  page.find(:css, ".pac-container .pac-item", match: :first).click

  select(date.day,   from: 'future_trip_departure_3i')
  select(date.strftime("%B"), from: 'future_trip_departure_2i')
  select(date.year,  from: 'future_trip_departure_1i')

  fill_in "future_trip_description", with: "Example Description"
end

Then /^I should(\ not)? see the future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |negative, from, to, departure|
  if negative
    expect(page).to_not have_content(departure)
    expect(page).to_not have_content(from)
    expect(page).to_not have_content(to)
  else
    expect(page).to have_content(departure)
    expect(page).to have_content(from)
    expect(page).to have_content(to)
  end
end

When /^I follow the edit future trip link$/ do
  within(".future_trips") do
    click_link("Edit")
  end
end

When /^I click on delete future trip$/ do
  within(".future_trips") do
    click_link("Delete")
  end
end

When /^I follow the send a message link besides the future trip$/ do
  within(".future_trips") do
    click_link("send message")
  end
end

When /^I fill in the message form$/ do
  fill_in("Message body", with: "hey ho!")
end

Then /^the future trip from Barcelona to Madrid should be geocoded$/ do
  future_trip = FutureTrip.last
  expect(future_trip.from_city).to eq("Barcelona")
  expect(future_trip.to_city).to eq("Madrid")
  expect(future_trip.from_country).to eq("Spain")
  expect(future_trip.to_country).to eq("Spain")
  expect(future_trip.from_country_code).to eq("ES")
  expect(future_trip.to_country_code).to eq("ES")
end

Then /^I should see the future trip of "([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |user, from, to|
  expect(page).to have_content(user)
  expect(page).to have_content(from)
  expect(page).to have_content(to)
end

Given /^"([^"]*)" logged a future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |username, from, to, departure|
  user = User.find_by_username(username.downcase) || FactoryBot.create(:user, email: "#{username}@hitchlog.com", username: username)
  user.future_trips.create(from: from, to: to, departure: departure)
end

When /^I follow the steps to create a new future trip$/ do
  visit future_trips_path
  click_link('Post it on the board')
end

