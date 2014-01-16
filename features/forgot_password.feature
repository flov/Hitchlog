Feature: Forgot Password
  Scenario: User retrieves password
    Given a hitchhiker called "flov"
    And I go to the forgot password page
    When I fill in "Email" with "flov@test.com"
    And I submit the form
    Then "flov@test.com" should receive an email

