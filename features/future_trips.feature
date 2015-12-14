Feature: Future Trips
  In order to create a hitchhiking partner platform
  As a hitchhiker
  I want to be able to view, add, edit and delete a future trip

  Background:
    Given I am logged in as "flov" from "Cairns"

  Scenario: View a future trip in someone elses profile and send him a message
    Given "Malte" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I go to the profile page of Malte
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I follow the send a message link besides the future trip
    And I fill in the message form
    And I submit the form
    Then I should see "Mail has been sent to Malte"

  Scenario: Delete a future trip
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    When I go to the profile page of Flov
    And show me the page
    And I click on delete future trip
    Then I should see "Your future trip from Barcelona to Madrid has been deleted"

  Scenario: View Future Trips
    Given "Malte" logged a future trip from "Cairns" to "Byron Bay" at the "21. December 2020"
     When I go to the future trips page
     Then I should see the future trip of "Malte" from "Cairns" to "Byron Bay"

  Scenario: Do not show past future trips
    Given "Flov" logged a future trip from "Barcelona" to "Madrid" at the "25 Jan 2010"
    When I go to the profile page of Flov
    Then I should not see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2010"

  @new_future_trip @javascript
  Scenario: New future trip
    When I follow the steps to create a new future trip
    And I fill in the future trip form with from "Barcelona" to "Madrid" at the "25 Jan 2020"
    And I submit the form
    Then I should see the future trip from "Barcelona" to "Madrid" at the "25 Jan 2020"
    And the future trip from Barcelona to Madrid should be geocoded
