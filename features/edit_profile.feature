Feature: Edit user
  In order to maintain the profiles
  As a user
  I want to be able to edit my profile

  Background:
    Given I am logged in as "flov"
     And I go to the edit profile page of Flov

  Scenario: Edit attributes
     When I fill in the following:
       | About you         | About me   |
       | CS user           | flov     |
       | Trustroots user   | flov     |
       | Gender (select)   | male     |
     And I submit the form
     Then I should see "About me"
     Then I should see "CS User: Flov"

