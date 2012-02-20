Feature: Create new trip
  Scenario: Log new trip if signed in
    Given I am logged in 
    And I go to the new trip page
    When I fill in the following:
      | From                   | Berlin           |
      | To                     | Hamburg          |
      | Departure              | 07/12/2011 10:00 |
      | Arrival                | 07/12/2011 20:00 |
      | Number of rides        | 1                |
      | Travelling    (select) | Alone            |
    And I press "Continue"
    Then I should see "From: Berlin"
    And I should see "To: Hamburg"
    And I should see "Duration: 10 hours"
    And I should see "Arrival: 07 December 2011 20:00"
    And I should see "Departure: 07 December 2011 10:00"
