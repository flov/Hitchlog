Feature: Edit trip
  @wip
  Scenario: Edit trip if signed in
    Given I am logged in 
    And I logged the following trip:
      | From                   | Berlin           |
      | To                     | Hamburg          |
      | Departure              | 07/12/2011 10:00 |
      | Arrival                | 07/12/2011 20:00 |
      | Number of rides        | 1                |
      | Travelling             | Alone            |
    When I go to the edit profile page of this trip
      # @trip.gmaps_duration = 11.hours.to_f
      # @trip.save!
      # visit edit_trip_path(@trip)
      # page.should have_content "According to Google Maps it took you 1 hour longer than if you drove directly"
      # page.should have_content "According to Google Maps you were 1 hour faster than if you drove directly"
      # page.should have_content "Duration: 10 hours"
      # page.should have_content "Hitchability factor: #{@trip.hitchability}"
      # page.should have_content "Gmap duration: 9 hours"
    
