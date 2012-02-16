Feature: Show Trip

  Scenario: Show the trip
    Given a trip exists
    And the user of this trip is "supertramp"
    And he did the trip 3 days ago
    And the distance was 1000 km
    And it took him 10 hours
    And google maps says it takes 9 hours and 15 minutes
    When I go to the page of this trip
    And I should see "3 days ago Supertramp hitchhiked 1,000km from Tehran to Shiraz with 1 ride"
    And  I should see "It took him 10 hours to do the trip"
    And  I should see "Google maps says it takes 9 hours 15 minutes for this route"
    And  I should see "so Supertramp was 45 minutes slower."
