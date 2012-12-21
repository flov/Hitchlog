Feature: Future Trips
  In order to create a hitchhiking partner platform
  As a hitchhiker
  I want to be able to view, add, edit and delete a future trip

  Background:
    Given I am logged in as "Flov" from "Cairns"

  Scenario: New future trip where a different hitchhiker lives close by
    Given a hitchhiker called "Malte" from "Cairns"
    When I go to the homepage
    And I follow "Find a new Hitchhiking Buddy"
    And I fill in the future trip form with from "Barcelona" to "Madrid" at the "25 Jan 2020"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    And "Malte" should receive a notification email

  Scenario: View and edit a future trip
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I go to the profile page of Flov
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I follow the edit future trip link
    And I fill in the future trip form with from "Barcelona" to "Paris" at the "20 Feb 2020"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Paris" at the "20 Feb 2020"

  Scenario: Delete a future trip
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I go to the profile page of Flov
    And I click on delete future trip
    Then I should see "Your future trip from Barcelona to Madrid has been deleted"

  Scenario: View Future Trips
    Given "Malte" logged a future trip from "Cairns" to "Byron Bay" at the "21. December 2015"
     When I go to the future trips page
     Then I should see "Malte wants to hitchhike from Cairns to Byron Bay at the 21 December 2015"
