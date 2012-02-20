Given /^a German trip$/ do
  @german_trip = Factory.build(:trip, :from => 'Berlin', :to => 'Freiburg')
  @german_trip.country_distances <<  CountryDistance.new(:country => 'Germany', :distance => 123123)
  @german_trip.save!
end

Given /^an English trip$/ do
  @english_trip = Factory.build(:trip, :from => 'London', :to => 'Manchester')
  @english_trip.country_distances <<  CountryDistance.new(:country => 'United Kingodm', :distance => 123123)
  @english_trip.save!
end

When /^I search for German trips$/ do
  select  "Germany", :from => "country"
  click_button "Search"
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

Given /^a trip with a story$/ do
  @trip_with_story = Factory.build(:trip, hitchhikes: 0)
  @trip_with_story.rides << Factory(:ride, story: Faker::Lorem::paragraph(sentence_count = 10))
  @trip_with_story.save!
end

Given /^a trip without a story$/ do
  @trip_without_story = Factory.create(:trip)
end

Then /^I should see a trip with a story$/ do
  page.should have_content @trip_with_story.from
end

Then /^I should see a trip without a story$/ do
  page.should have_content @trip_without_story.from
end

When /^I search for trips with stories$/ do
  check "Story"
  click_button "Search"
end

Then /^I should see trips with stories$/ do
  page.find("#trip_#{@trip_with_story.id}").should have_content("#{@trip_with_story.rides.first.story[0..150]}")
end

Then /^I should not see trips without stories$/ do
  lambda { page.find("#trip_#{@trip_without_story.id}") }.should raise_error(Capybara::ElementNotFound)
end

When /^I fill in the new trip form and I submit it$/ do
  fill_in "From", :with => "Berlin"
  fill_in "To", :with => "Freiburg"
  fill_in "Departure", :with => "07/12/2011 10:00"
  fill_in "Arrival", :with => "07/12/2011 20:00"
  fill_in "Number of rides", :with => "2"
  fill_in "From", :with => "Berlin"
  click_button "Continue"
end

Given /^I logged the following trip:$/ do |table|
  @user = Factory :user unless @user
  @trip = Factory.build :trip
  table.rows_hash.each do |name, value|
    # Todo: evaluate table and fill attributes of @trip
  end
  @trip.save!
end
