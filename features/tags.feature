Feature: Tags
  In order to organize rides more
  As a user
  I want to be able to tag a ride

  Scenario: User tags a ride
    Given I am logged in as "flo"
    And "flo" logged a trip
    When I go to the edit trip page
    And I type in "adventurous" as a tag
    And I press "Save Ride"
    Then I should see "Adventurous" as a tag on the trip
