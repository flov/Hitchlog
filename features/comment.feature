Feature: Comments
  In order to write comments on a trip
  As a user
  I want to be able to post a comment on a trip

  Scenario: User is signed in and comments
    Given I am logged in
    And a trip exists
    When I go to the page of this trip
    Then I should see "Add Comment"
    When I fill in a comment with "Wow!"
    And I press "Add Comment"
    Then I should see Wow! in the comments dialog

  Scenario: Unknown user tries to comment
    Given a trip exists
    When I go to the page of this trip
    Then I should see "Log in or register to comment on this trip"

  In order to see the comments of a user
  As a visitor
  I want to be able to see all comments on any trips of a user

  Scenario: Visitor sees comments on a trip
    Given a hitchhiker called "Malte"
    And a Trip from "Barcelona" to "Berlin"
    And "Malte" has commented on this trip with "Geiler Trip man!"
    When I go to the profile page of "Malte"
    Then I should see that he posted 1 comment
    When I click on his comment stats
    Then I should see the trip to the comment "Geiler Trip man!"
    When I click on the trip
    Then I should be on the trip page from "Barcelona" to "Berlin"
