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


  Scenario: Manage rides
    Given I am logged in as "flo"
    And "flo" logged a trip with 1 ride
    When I go to the edit page of that trip
    Then I should be able to choose a vehicle with "car", "truck", "motorcycle", "ship" and "plane"
    And I should be able to edit 1 ride
    When I click on "Add Ride"
    Then I should be able to edit 2 ride

