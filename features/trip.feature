Feature: Trip feature
  @trips
  Scenario: Creating new trips
    Given I am logged in as flov
    When I go to the new trip page
    And I fill in the following:
      | From                | Barcelona        |
      | To                  | Madrid           |
      | Number of rides     | 3                |
      | Started at          | 20/10/2010 06:00 |
      | Duration (in hours) | 5                |
    And I select "with 1 Person" from "Travelling"
    And I press "trip_submit"
    Then I should see "Step 2/2"
    And I should see "Ride 1"
    And I should see "Ride 2"
    And I should see "Ride 3"

  @javascript @wip
  Scenario: Arrival time gets displayed once you enter started at and duration
    Given I am logged in as hitchhiker
    When I go to the new trip page
    And I fill in the following:
      | Started at          | 20/10/2010 06:00 |
      | Duration (in hours) | 5                |
    Then I should see "Arrival time"
  
