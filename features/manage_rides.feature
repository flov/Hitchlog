Feature: Manage rides
  Background:
    Given I am logged in as "flo"
    And "flo" logged a trip with 1 ride
    When I go to the edit page of that trip

  Scenario: Add Trip
    Then I should be able to edit 1 ride
    When I click on "Add Ride"
    Then I should be able to edit 2 ride

  Scenario: manage vehicle
    Then I should be able to choose a vehicle with "car", "truck", "motorcycle" and "plane"

