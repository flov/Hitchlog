When("I type in {string} as a tag") do |string|
  fill_in('ride_tag_list', with: string)
end

Then /^I should see "([^"]*)" as a tag on the trip$/ do |tag|
  within ".entry-meta a" do
    expect(page).to have_content(tag)
  end
end

Given /^a trip with a tagged ride "([^"]*)"$/ do |tag|
  trip = FactoryGirl.create(:trip)
  FactoryGirl.create(:ride, trip_id: trip.id, tag_list: tag, number: (Ride.count+1))
end

When /^I click on the "([^"]*)" tag$/ do |tag|
  within '.tags' do
    click_link tag
  end
end

Then /^I should(\ not)? see the trip with the "([^"]*)" tag$/ do |negative, tag|
  if negative
    expect(page).to_not have_content(tag)
  else
    expect(page).to have_content(tag)
  end
end

Given /^"([^"]*)" logged (\d+) trips? with a tagged ride "([^"]*)"$/ do |username, number_of_trips, tag|
  user = User.find_by_username(username)
  number_of_trips.to_i.times do
    trip = FactoryGirl.create(:trip, user_id: user.id)
    ride = FactoryGirl.create(:ride, trip_id: trip.id, tag_list: tag)
  end
end

Then /^I should see a tag cloud with "([^"]*)" and "([^"]*)"$/ do |tag1, tag2|
  within '.tag_cloud' do
    expect(page).to have_content(tag2)
    expect(page).to have_content(tag1)
  end
end
