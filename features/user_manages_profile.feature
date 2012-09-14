Feature: Show User
  Scenario: A User has the CS name set
    Given a hitchhiker called "supertramp"
    And his CS user is "supertramp"
    When I go to the profile of "supertramp"
    Then I should see "CS User: Supertramp"
