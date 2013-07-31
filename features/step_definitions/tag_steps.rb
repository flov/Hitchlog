When /^I type in "([^"]*)" as a tag$/ do |tag|
  fill_in('ride_tag_list', with: tag)
end

Then /^I should see "([^"]*)" as a tag on the trip$/ do |tag|
  within ".entry-meta" do
    page.should have_content(tag)
  end
end

Given /^a trip with a tagged ride "([^"]*)"$/ do |tag|
  trip = FactoryGirl.create(:trip)
  ride = FactoryGirl.create(:ride, trip_id: trip.id, tag_list: tag)
end

When /^I click on the "([^"]*)" tag$/ do |tag|
  click_link tag
end

Then /^I should(\ not)? see the trip with the "([^"]*)" tag$/ do |negative, tag|
  if negative
    page.should_not have_content(tag)
  else
    page.should have_content(tag)
  end
end
