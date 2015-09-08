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

Given /^6 trips exist with a different experience respectively$/ do
  Ride::EXPERIENCES.each do |exp|
    trip = FactoryGirl.build(:trip)
    trip.rides << FactoryGirl.create(:ride,
                                     experience: exp)
    trip.save!
  end
end

When /^I search for trips with an? "([^"]*)" experience$/ do |experience|
  select experience, :from => "q_rides_experience_eq"
  click_button "search"
end

Then /^I should see a trip with an? "([^"]*)" experience$/ do |experience|
  page.should have_css('table.trips span.very-good')
end

Then /^I should not see a trip with an? "([^"]*)" experience$/ do |experience|
  page.should_not have_css("table.trips span.#{experience}")
end


