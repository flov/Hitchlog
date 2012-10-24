Feature: Comments Feature
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
