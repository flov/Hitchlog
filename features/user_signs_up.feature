Feature: Sign up and sign out
  Scenario: User signs up
    When I go to the signup page
    And I sign up as "florian"
    Then I should be on the homepage
    And  I should see "Welcome to the Hitchlog! A message with a confirmation link has been sent to your email address"

  Scenario: sign out
    Given I am logged in
    When I click on the sign out link
    Then I should be signed off

