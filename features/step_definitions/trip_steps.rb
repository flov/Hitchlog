Given /^a trip exists from "([^"]*)" to "([^"]*)"$/ do |from, to|
  @trip = FactoryGirl.create(:trip, from: from, to: to)
end

Given /^a trip exists$/ do
  FactoryGirl.create(:trip)
end

Given /^the user the trip from "([^"]*)" to "([^"]*)" is "([^"]*)"$/ do |from, to, username|
  trip = Trip.where(from: from, to: to).first
  user = trip.user
  user.username = username
  user.save!
end

Given /^the distance of the trip from "([^"]*)" to "([^"]*)" was (\d+) km$/ do |from, to, number|
  trip = Trip.where(from: from, to: to).first
  trip.distance = number.to_i * 1000
  trip.save!
end

Given /^he did the trip (\d+) days ago$/ do |number|
  @trip.departure = number.to_i.days.ago
  @trip.save!
end

Given /^it took him (\d+) hours$/ do |number|
  @trip.arrival = @trip.departure + number.to_i.hours
end

Given /^google maps says it takes 9 hours and 15 minutes$/ do
  @trip.gmaps_duration = (9.hours + 15.minutes).to_i
  @trip.save!
end

Given /^a German trip exists$/ do
  @german_trip = FactoryGirl.build(:trip, :from => 'Berlin', :to => 'Freiburg')
  @german_trip.country_distances <<  CountryDistance.new(:country => 'Germany', :distance => 123123)
  @german_trip.save!
end

Given /^an English trip exists$/ do
  @english_trip = FactoryGirl.build(:trip, :from => 'London', :to => 'Manchester')
  @english_trip.country_distances <<  CountryDistance.new(:country => 'United Kingodm', :distance => 123123)
  @english_trip.save!
end

Given /^a trip with a story$/ do
  @trip_with_story = FactoryGirl.build(:trip, hitchhikes: 0)
  @trip_with_story.rides << FactoryGirl.create(:ride,
                                               story: Faker::Lorem::paragraph(sentence_count = 10))
  @trip_with_story.save!
end

Given /^a trip from "([^"]*)" to "([^"]*)" with a photo on ride$/ do |from, to|
  trip = FactoryGirl.create(:trip, from: from, to: to)
  ride = trip.rides.first
  ride.photo = File.open("#{Rails.root}/features/support/images/thumb.png")
  ride.save
end

Then /^I should see the trip from "([^"]*)" to "([^"]*)" in the hitchslide$/ do |from, to|
  expect(page.find("#hitchslide")).to have_content("from #{from} to #{to}")
end

When /^I click on the next button$/ do
  click_link("Next")
end

When /^I fill in the new trip form "([^"]*)" to "([^"]*)"$/ do |from, to|
  VCR.use_cassette 'berlin' do
    fill_in('trip_from', with: from, exact: true)
    page.find(:css, ".pac-container .pac-item", match: :first).click
  end

  VCR.use_cassette 'hamburg' do
    fill_in('trip_to', with: to, exact: true)
    page.find(:css, ".pac-container .pac-item", match: :first).click
  end

  select('1', from: 'Number of rides')
  select('alone', from: 'Traveling with')
end

Then /^the from and to location should be geocoded$/ do
  sleep(10)
  # from geocoding:
  expect(find('#trip_from_formatted_address', visible: false).value).to eq('Berlin, Germany')
  expect(find('#trip_from_city', visible: false).value).to eq('Berlin')
  expect(find('#trip_from_country', visible: false).value).to eq('Germany')
  expect(find('#trip_from_country_code', visible: false).value).to eq('DE')
  expect(find('#trip_from_lat', visible: false).value.to_i).to eq(52)
  expect(find('#trip_from_lng', visible: false).value.to_i).to eq(13)

  expect(find('#trip_to_formatted_address', visible: false).value).to eq('Hamburg, Germany')
  expect(find('#trip_to_city', visible: false).value).to eq('Hamburg')
  expect(find('#trip_to_country', visible: false).value).to eq('Germany')
  expect(find('#trip_to_country_code', visible: false).value).to eq('DE')
  expect(find('#trip_to_lat', visible: false).value.to_i).to eq(53)
  expect(find('#trip_to_lng', visible: false).value.to_i).to eq(9)

  expect(find('#trip_distance', visible: false).value.to_i).to_not eq(0)
  expect(find('#trip_gmaps_duration', visible: false).value.to_i).to_not eq(0)
end

Then /^I should see the details of the trip again$/ do
  expect(find('#from')).to have_content('Berlin, Germany')
  expect(find('#to')).to have_content('Reeperbahn, Hamburg, Germany')
  expect(find('#distance')).to have_content('291 km')
  expect(find('#no_of_rides')).to have_content('4')
  expect(find('#departure')).to have_content('07/12/2011 10:00')
  expect(find('#arrival')).to have_content('07/12/2011 20:00')
end

When /^I confirm that the data is correct$/ do
  click_button("Create Trip")
end

Given /^"([^"]*)" logged a trip with (\d+) ride$/ do |username, number_of_rides|
  user = User.find_by_username username
  FactoryGirl.create :trip, user_id: user.id, hitchhikes: number_of_rides
end

Then /^I should be able to edit (\d+) ride$/ do |number|
  expect(page.all(".accordion_content").count).to eql(number.to_i)
end

When /^I fill in the ride form$/ do
  fill_in('ride_title', with: 'Example Title')
  fill_in('ride_story', with: 'Example Story')
  fill_in('ride_tag_list', with: 'Example Tag, Example Tag 2')
  select('car', from: 'ride_vehicle')
  fill_in('ride_waiting_time', with: '20')
  fill_in('ride_duration', with: '4')
  select('male', from: 'ride_gender')
end

When /^I submit the ride form$/ do
  find('#accordion input[type="submit"]').click
end

Then /^I should see the ride information$/ do
  expect(page).to have_content('Example Title')
  expect(page).to have_content('Example Story')
  expect(page).to have_content('Example Tag')
  expect(page).to have_content('Example Tag 2')
  expect(page).to have_content('car')
  expect(page).to have_content('20 minutes')
  expect(page.find('.story_icons')).to have_css('i.fa-male')
end
