Feature: Future Trips
  In order to create a hitchhiking partner platform
  As a hitchhiker
  I want to be able to view, add, edit and delete a future trip

  Background:
    Given I am logged in as "Flov" from "Cairns"

  @javascript @geocode_1 @geocode_2 @geocode_3 @geocode_4 @wip
  Scenario: New future trip WITH a nearby hitchhiker
    Given a hitchhiker called "Malte" from "Cairns"
    When I go to the new future trip page
    And I fill in the future trip form with from "Barcelona" to "Madrid" at the "25 Jan 2014"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    And the future trip from Barcelona to Madrid should be geocoded
    And "Malte" should receive an email with subject "[Hitchlog] Flov is looking for a hitchhiking buddy from Barcelona to Madrid"

  @javascript @wip
  Scenario: New future trip WITHOUT a nearby hitchhiker
    Given a hitchhiker called "Malte" from "Brisbane"
    When I go to the homepage
    And I follow "Find a new Hitchhiking Buddy"
    And I fill in the future trip form with from "Barcelona" to "Madrid" at the "25 Jan 2014"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    And "Malte" should receive no email

  @javascript @wip
  Scenario: View and edit a future trip in your profile
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    When I go to the profile page of Flov
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    When I follow the edit future trip link
    And I fill in the future trip form with from "Barcelona" to "Paris" at the "20 Feb 2014"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Paris" at the "20 Feb 2014"
    And the future trip from Barcelona to Paris should be geocoded

  Scenario: View a future trip in someone elses profile and send him a message
    Given "Malte" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    When I go to the profile page of Malte
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    When I follow the send a message link besides the future trip
    And I fill in the message form
    And I submit the form
    Then I should see "Mail has been sent to Malte"

  Scenario: Delete a future trip
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2014"
    When I go to the profile page of Flov
    And I click on delete future trip
    Then I should see "Your future trip from Barcelona to Madrid has been deleted"

  Scenario: View Future Trips
    Given "Malte" logged a future trip from "Cairns" to "Byron Bay" at the "21. December 2015"
     When I go to the future trips page
     Then I should see "Malte wants to hitchhike from Cairns to Byron Bay at the 21 December 2015"
