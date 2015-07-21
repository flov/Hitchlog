Feature: Sign up and sign out
  Scenario: User signs up
    When I go to the signup page
    And I sign up as "florian"
    Then I should be on the profile page of florian
    And  I should see "Welcome To The Hitchlog!"

  Scenario: sign out
    Given I am logged in
    When I click on the sign out link
    Then I should be signed off

