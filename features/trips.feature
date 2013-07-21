Feature: User manages trips
  In order to keep my trips up to date
  As a user
  I want to add/edit and view my own trips

  @javascript @trips
  Scenario: Log new trip
    Given I am logged in
    And I go to the new trip page
    When I fill in the new trip form
    Then the from and to location should be geocoded
    And it should route from origin to destination
    When I submit the form
    Then I should be on the edit trip page

