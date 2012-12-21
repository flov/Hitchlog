Feature: Edit user
  In order to maintain the profiles
  As a user
  I want to be able to edit my profile

  Background:
    Given I am logged in as "flov"

  Scenario: Edit attributes
     When I go to the edit profile page
     And I fill in the following:
       | About you         | About me |
       | CS user           | My_cs_user |
       | Gender (select)   | male     |
     And I press "Save"
     Then I should see "About me"
     And  I should see "My_cs_user"

  #@javascript
  Scenario: change location
     When I go to the edit profile page
     And I change my location to "Cairns, Australia"
     And I press "Save"
     Then the current location of "flov" should be "Cairns, Australia"
