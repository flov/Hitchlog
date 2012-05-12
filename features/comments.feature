Feature: Comments Feature
  Scenario: Comments if signed in
    Given I am logged in
    And a trip exists
    When I go to the page of this trip
    Then I should see "Add Comment"
    When I fill in a comment with "Wow!"
    And I press "Add Comment"
    Then I should see Wow! in the comments dialog

  Scenario: Comments if not signed in
    Given a trip exists
    When I go to the page of this trip
    Then I should see "Log in or register to comment on this trip"
