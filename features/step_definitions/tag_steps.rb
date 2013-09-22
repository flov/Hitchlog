When /^I type in "([^"]*)" as a tag$/ do |tag|
  fill_in('ride_tag_list', with: tag)
end

Then /^I should see "([^"]*)" as a tag on the trip$/ do |tag|
  within ".entry-meta a" do
    page.should have_content(tag)
  end
end

Given /^a trip with a tagged ride "([^"]*)"$/ do |tag|
  trip = FactoryGirl.create(:trip)
  ride = FactoryGirl.create(:ride, trip_id: trip.id, tag_list: tag)
end

When /^I click on the "([^"]*)" tag$/ do |tag|
  within '.tags' do
    click_link tag
  end
end

Then /^I should(\ not)? see the trip with the "([^"]*)" tag$/ do |negative, tag|
  if negative
    page.should_not have_content(tag)
  else
    page.should have_content(tag)
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
    page.should have_content(tag2)
    page.should have_content(tag1)
  end
end
