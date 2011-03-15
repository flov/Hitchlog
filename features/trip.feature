Feature: Trip feature
  @trips
  Scenario: Creating new trips
    Given I am logged in as hitchhiker
    When I go to the new trip page
    And I fill in the following:
      | From                | Barcelona        |
      | To                  | Madrid           |
      | Started at          | 20/10/2010 06:00 |
      | Duration (in hours) | 5                |
      | Number of rides     | 2                |
    And I press "Submit"
    Then I should see "Thanks for creating a new trip"

  @javascript @wip
  Scenario: Arrival time gets displayed once you enter started at and duration
    Given I am logged in as hitchhiker
    When I go to the new trip page
    And I fill in the following:
      | Started at          | 20/10/2010 06:00 |
      | Duration (in hours) | 5                |
    Then I should see "Arrival time"
  
