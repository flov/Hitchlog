require 'spec_helper'

describe "trips" do
  describe "GET /trips/index" do
    before do
      @german_trip = Factory.build(:trip, :from => 'Berlin', :to => 'Freiburg')
      @german_trip.country_distances <<  CountryDistance.new(:country => 'Germany', :distance => 123123)
      @german_trip.save!
      @english_trip = Factory.build(:trip, :from => 'London', :to => 'Manchester')
      @english_trip.country_distances <<  CountryDistance.new(:country => 'United Kingodm', :distance => 123123)
      @english_trip.save!
      @trip_with_story = Factory.create(:trip, :story => Faker::Lorem::paragraph(sentence_count = 10),
                                        :from => 'Tehran', :to => 'Shiraz', :distance => 555555)
    end

    it "should be able to sort trips by country" do
      visit trips_path
      page.should have_content @german_trip.from
      page.should have_content @english_trip.from
      select  "Germany", :from => "country"
      click_button "Search"
      page.should have_content @german_trip.from
      page.should_not have_content @english_trip.from
    end

    it "should sort trips after stories", :focus => true do
      visit trips_path
      check "Only stories"
      click_button "Search"
      page.should have_content @trip_with_story.from
      save_and_open_page
      page.should have_content "#{@trip_with_story.story[0..150]}"
      page.should_not have_content @german_trip.from
    end
  end

  describe "GET /trips/new" do
    it "should be able to log a new trip if signed_in" do
      user = Factory :user
      visit new_user_session_path
      fill_in "Username", :with => user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      click_link "Log Your First Trip"
      fill_in "From", :with => "Berlin"
      fill_in "To", :with => "Freiburg"
      fill_in "Started at", :with => "07/12/2011 10:00"
      fill_in "Number of rides", :with => "2"
      fill_in "From", :with => "Berlin"
      fill_in "Duration (in hours)", :with => "5"
      click_button "Continue"
      page.should have_content "Trip details"
    end
  end
end

