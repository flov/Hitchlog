Feature: Edit user
  In order to maintain the profiles
  As a user
  I want to be able to edit my profile

  Background:
    Given I am logged in as "flov"
     And I go to the edit profile page of Flov

  Scenario: Edit attributes
     When I fill in the following:
       | About you         | About me |
       | CS user           | My_cs_user |
       | Gender (select)   | male     |
     And I submit the form
     Then I should see "About me"
     And  I should see "My_cs_user"

