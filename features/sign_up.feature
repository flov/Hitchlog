Feature: User signs up
  Scenario:
    When I go to the signup page
    And I sign up as "florian"
    Then I should be on the profile page of florian
    And  I should see "Welcome aboard Florian!"
