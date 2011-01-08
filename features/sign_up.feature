Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

  Scenario: User signs up with invalid data
    When I go to the sign up page
    And I fill in the following:
      | Email                 | invalidemail |
      | Username              | user         |
      | Password              | invalidemail |
      | Password confirmation |              |
    And I press "Sign up"
    Then I should see error messages
    
  Scenario: User signs up with valid data
    When I go to the sign up page
    And I fill in the following:  
    | Email                 | user@example.com |
    | Username              | alex             |
    | Password              | password         |
    | Password confirmation | password         |
    And I press "Sign up"
    Then I should see "Thank you for signing up."
    And I should not see "a confirmation was sent to your e-mail."
