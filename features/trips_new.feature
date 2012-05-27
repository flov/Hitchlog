Feature: Create new trip
  Scenario: Log new trip if signed in
    Given I am logged in 
    And I go to the new trip page
    When I fill in the following:
      | From                       | Berlin           |
      | To                         | Hamburg          |
      | Departure                  | 07/12/2011 10:00 |
      | Arrival                    | 07/12/2011 20:00 |
      | Number of rides            | 1                |
      | Traveling with    (select) | alone            |
    And I press "Continue"
    Then I should see "Edit Trip"
