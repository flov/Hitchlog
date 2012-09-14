Feature: Edit user
  As a user I want to be able to edit my profile

  Background:
    Given a hitchhiker 
      And I am logged in

  Scenario:
     When I go to the edit profile page
     And I fill in "About you" with "my Biography"
     And I fill in "CS user" with "flov"
     And I select "male" from "Gender"
     And I press "Save"
     Then I should see "my Biography"
     And I should see "CS User: Flov"
