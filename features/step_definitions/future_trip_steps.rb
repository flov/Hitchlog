When /^I fill in the future trip form with from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |from, to, departure|
  date = Date.parse departure

  fill_in "To",   with: to
  find(".ui-autocomplete .ui-corner-all").click
  fill_in "From", with: from
  find(".ui-autocomplete .ui-corner-all").click
  select(date.day,   from: 'future_trip_departure_3i')
  select(date.strftime("%B"), from: 'future_trip_departure_2i')
  select(date.year,  from: 'future_trip_departure_1i')
  fill_in "Description", with: "Example Description"
end

Then /^I should(\ not)? see the future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |negative, from, to, departure|
  if negative
    page.should_not have_content(departure)
    page.should_not have_content(from)
    page.should_not have_content(to)
  else
    page.should have_content(departure)
    page.should have_content(from)
    page.should have_content(to)
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
  future_trip.from_city.should == "Barcelona"
  future_trip.to_city.should   == "Madrid"
  future_trip.from_country.should == "Spain"
  future_trip.to_country.should == "Spain"
  future_trip.from_country_code.should == "ES"
  future_trip.to_country_code.should == "ES"
end

Then /^the future trip from Barcelona to Madrid should be geocoded$/ do
  future_trip = FutureTrip.last
  future_trip.from_city.should == "Barcelona"
  future_trip.to_city.should   == "Paris"
  future_trip.from_country.should == "Spain"
  future_trip.to_country.should == "France"
  future_trip.from_country_code.should == "ES"
  future_trip.to_country_code.should == "FR"
end

Then /^I should see the future trip of "([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |user, from, to|
  page.should have_content(user)
  page.should have_content(from)
  page.should have_content(to)
end

Given /^"([^"]*)" logged a future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |username, from, to, departure|
  user = User.find_by_username(username.downcase) || FactoryGirl.create(:user, email: "#{username}@hitchlog.com", username: username)
  user.future_trips.create(from: from, to: to, departure: departure)
end
