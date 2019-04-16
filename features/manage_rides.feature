Feature: Manage rides
  Background:
    Given I am logged in as "flo"
    And "flo" logged a trip with 1 ride
    When I go to the edit page of that trip

  Scenario: Add Trip
    Then I should be able to edit 1 ride
    When I click on "Add Ride"
    Then I should be able to edit 2 ride

  Scenario: Manage ride
    When I fill in the following:
      | ride_title             | Example Title              |
      | ride_story             | Example Story              |
      | ride_tag_list          | Example Tag, Example Tag 2 |
      | ride_vehicle  (select) | car                        |
      | ride_waiting_time      | 20                         |
      | ride_duration          | 4                          |
      | ride_gender (select)   | male                       |
      | YouTube ID             | ksMkENKMlyk                |
    And I submit the ride form
    Then I should see the ride information

