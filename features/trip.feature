Feature: Trip feature

  Scenario: Going to the trips page when logged in and ensure links
    Given I am logged in as alex
    When I go to the trips page
    Then I should see "New Trip"

  Scenario: Creating new trips
    Given I am logged in as alex
    When I go to the new trip page
    And I fill in the following:
      | From            | Belgrade         |
      | To              | Odessa           |
      | Started at      | 20/10/2010 06:00 |
      | Arrival at      | 20/10/2010 12:00 |
      | Number of rides | 2                |
    And I press "Submit"
    Then I should see "Thanks for creating a new trip"
