Feature: Signs up with facebook
  Scenario: User signs up with facebook without existing account
    When I go to the homepage
    And I login with facebook
    Then  I should see "Successfully authenticated from Facebook account"
