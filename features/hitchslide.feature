Feature: Hitchslide
  In order to get an impression of some trips
  As a visitor of the hitchlog
  I want to be able to see a random photo of a trip

  @javascript
  Scenario:
    Given a trip from "Barcelona" to "Madrid" with a photo on ride
    When I go to the homepage
    Then I should see the trip from "Barcelona" to "Madrid" in the hitchslide 
    Given a trip from "Madrid" to "Paris" with a photo on ride
    When I click on the next button
    Then I should see the trip from "Madrid" to "Paris" in the hitchslide 
