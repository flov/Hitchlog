Feature: Hitchhike feature
  In order to post hitchhikes
  A user
  Should be able post a hitchhike

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
    | Username              | flov             |
    | Password              | password         |
    | Password confirmation | password         |
    And I press "Sign up"
    Then I should see "Signed in as flov"