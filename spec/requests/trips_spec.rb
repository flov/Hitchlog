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
      @trip_with_story = Factory.create(:trip,
                                        :story => Faker::Lorem::paragraph(sentence_count = 10),
                                        :from => 'Tehran',
                                        :to => 'Shiraz',
                                        :distance => 555555)
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

    it "should sort trips after stories" do
      visit trips_path
      check "Only stories"
      click_button "Search"
      page.should have_content @trip_with_story.from
      page.should have_content "#{@trip_with_story.story[0..150]}"
      page.should_not have_content @german_trip.from
    end
  end

  describe "GET /trips/new" do
    before do
      @user = Factory :user
    end

    it "should be able to log a new trip if signed_in" do
      visit new_user_session_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      click_link "Log Your First Trip"
      fill_in "From", :with => "Berlin"
      fill_in "To", :with => "Freiburg"
      fill_in "Departure", :with => "07/12/2011 10:00"
      fill_in "Arrival", :with => "07/12/2011 20:00"
      fill_in "Number of rides", :with => "2"
      fill_in "From", :with => "Berlin"
      click_button "Continue"
      page.should have_content "Duration: 10 hours"
      page.should have_content "Arrival: 07 December 2011 20:00"
      page.should have_content "Departure: 07 December 2011 10:00"
    end
  end

  describe "GET /trips/show" do
    before do
      @trip = Factory(:trip, 
                      :story => Faker::Lorem::paragraph(sentence_count = 10),
                      :from => 'Tehran',
                      :to => 'Shiraz',
                      :distance => 100_000, 
                      :hitchhikes => 3)
      @ride = @trip.rides.first
      @ride.waiting_time = 20
      @ride2 = @trip.rides.last
      @ride2.duration = 3
      @ride.save!; @ride2.save!
    end

    it "should display rides properly" do
      visit trip_path(@trip)
      page.should have_content "Ride 1/3"
      page.should have_content "Ride 3/3"
    end
  end

  describe "GET /trips/edit" do
    before do
      @user = Factory(:user)
      @trip = Factory(:trip, 
                      :story => Faker::Lorem::paragraph(sentence_count = 10),
                      :from => 'Tehran',
                      :to => 'Shiraz',
                      :start => "07/12/2011 10:00",
                      :end   => "07/12/2011 20:00",
                      :gmaps_duration   => 9.hours.to_f,
                      :distance => 100_000, 
                      :hitchhikes => 3,
                      :user => @user)
      visit new_user_session_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      visit edit_trip_path(@trip)
    end

    xit "attaches stories to trips" do
      fill_in "Story", :with => "What a hilarious Trip!"
    end

    it "displays gmaps_difference if slower" do
      page.should have_content "According to Google Maps it took you 1 hour longer than if you drove directly"
    end

    it "displays gmaps_difference if faster" do
      @trip.gmaps_duration = 11.hours.to_f
      @trip.save!
      visit edit_trip_path(@trip)
      page.should have_content "According to Google Maps you were 1 hour faster than if you drove directly"
    end

    it "displays duration" do
      page.should have_content "Duration: 10 hours"
    end

    it "should display hitchability factor" do
      page.should have_content "Hitchability factor: #{@trip.hitchability}"
    end

    it "should display Gmap Duration" do
      page.should have_content "Gmap duration: 9 hours"
    end

    it "should display rides properly" do
      page.should have_content "Add/Edit Story"
    end
  end
end

