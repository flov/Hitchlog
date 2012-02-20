Feature: Edit user
  As a user I want to be able to edit my profile

  Background:
    Given a hitchhiker 
      And I am logged in

  Scenario: 
     When I go to the edit profile page
     Then I should see "About you"
     And  I should see "CS user"
     And  I should see "Avatar"
     And  I should see "Hitchlog only supports avatars through Gravatar."
