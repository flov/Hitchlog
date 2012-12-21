Feature: Edit user
  In order to find hitchhiking buddies
  As a hitchhiker
  I want to be able to view future hitchhiking trips and contact the hitchhikers

  Scenario: view buddy requests
    Given "Flov" logged a future trip from "Cairns" to "Byron Bay" at the "21. December 2015"
     When I go to the hitchhiking buddies page
     Then I should see "Flov wants to hitchhike from Cairns to Byron Bay at the 21 December 2015"
