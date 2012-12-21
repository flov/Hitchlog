Feature: Edit user
  In order to find hitchhiking buddies
  As a hitchhiker
  I want to be able to view future hitchhiking trips and contact the hitchhikers

  Scenario: view buddy requests
    Given "Flov" logged a future trip from "Cairns" to "Byron Bay" at the "21. December 2015"
     When I go to the hitchhiking buddies page
     Then I should see "Flov wants to hitchhike from Cairns to Byron Bay at the 21 December 2015"

  Scenario: File a new future travel to find a new hitchhiking buddy
    Given a hitchhiker called "Malte" from "Cairns"
    And I am logged in as "Flov" from "Cairns"
    When I go to the homepage
    And I follow "Find a new Hitchhiking Buddy"
    And I fill in "From" with "Barcelona"
    And I fill in "To" with "Madrid"
    And I fill in "Departure" with "21 December 2012"
    Then I should see the future trip from "Barcelona" to "Madrid" in the profile page
    And "Malte" should receive a notification email

