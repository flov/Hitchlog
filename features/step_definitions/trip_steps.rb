Given /^the user of this trip is "([^"]*)"$/ do |username|
  @trip = Trip.last
  user = @trip.user
  user.username = username
  user.save!
end

Given /^the distance was (\d+) km$/ do |number|
  @trip.distance = number.to_i * 1000
end

Given /^he did the trip (\d+) days ago$/ do |number|
  @trip.start = number.to_i.days.ago
end

Given /^it took him (\d+) hours$/ do |number|
  @trip.end = @trip.start + number.to_i.hours
end

Given /^google maps says it takes 9 hours and 15 minutes$/ do
  @trip.gmaps_duration = (9.hours + 15.minutes).to_i
  @trip.save!
end

Given /^a German trip exists$/ do
  @german_trip = Factory.build(:trip, :from => 'Berlin', :to => 'Freiburg')
  @german_trip.country_distances <<  CountryDistance.new(:country => 'Germany', :distance => 123123)
  @german_trip.save!
end

Given /^an English trip exists$/ do
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

Given /^each one of these 6 trips have a different experience$/ do
  experiences = ['extremely positive', 'positive', 'neutral', 'negative', 'extremely negative']
  trips = Trip.all
  6.times do |i|
    ride = trips[i].rides.first
    ride.experience = experiences[i]
    ride.save!
  end
end

When /^I search for trips with an "([^"]*)" experience$/ do |experience|
  select experience, :from => "experience"
  click_button "Search"
end

Then /^I should see a trip with an? "([^"]*)" experience$/ do |experience|
  page.should have_content("#{experience}.png")
end

Then /^I should not see a trip with an? "([^"]*)" experience$/ do |experience|
  page.should_not have_content("#{experience}.png")
end

