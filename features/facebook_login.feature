Feature: Signs up with facebook
  Scenario: User signs up with facebook without existing account
    When I go to the homepage
    And I login with facebook
    Then  I should see "Successfully authenticated from Facebook account"

  Scenario: User has already signed up without facebook and signs up with Facebook
    Given a user with email same as his facebook account
    When I go to the homepage
    And I login with facebook
    Then  I should see "Successfully authenticated from Facebook account"
