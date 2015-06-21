Feature: Future Trips
  In order to promote finding a hitchhiking buddy
  As a visitor of the page
  I want to be able to see upcoming hitchhiking trips

  Scenario: Show hitchhiking trips on homepage
    Given "Malte" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I go to the home page
    Then I should see that "Malte" is searching for a hitchhiking buddy from "Barcelona" to "Madrid"

