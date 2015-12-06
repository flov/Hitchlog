
Feature: Friends
  In order to follow others and see their newest trips on the dashboard
  As a user
  I want to be able to follow another hitchhiker

  @wip
  Scenario: User follows a user
    Given I am logged in as "florian"
    And a hitchhiker called "ludovic"
    When I visit the profile page of "ludovic"
    And I follow "follow"
    Then I should see "You are now following Ludovic."
    When "ludovic" logs another trip
    Then I should receive an email about ludovics trip
    And I should see ludovics trip on the dashboard

