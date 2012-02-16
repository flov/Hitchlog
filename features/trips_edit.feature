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
