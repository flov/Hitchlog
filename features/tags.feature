Feature: Tags
  In order to organize rides more
  As a user
  I want to be able to tag a ride

  Scenario: User tags a ride
    Given I am logged in as "flo"
    And "flo" logged a trip
    When I go to the edit trip page
    And I type in "adventurous" as a tag
    And I press "Save Ride"
    And show me the page
    Then I should see "adventurous" as a tag on the trip

  Scenario: User clicks on tag in a trip
    Given a trip with a tagged ride "dangerous"
    And a trip with a tagged ride "boring"
    When I go to the page of this trip
    And I click on the "dangerous" tag
    Then I should be on the tag page of dangerous
    And I should see the trip with the "dangerous" tag
    And I should not see the trip with the "boring" tag

  @wip
  Scenario: User tags ride for stories which have not been tagged yet
    Given I am logged in as "flo"
     And "flo" logged a trip with a story but without tag
    When I go to the profile page of flo
    Then I should see "Missing tags for 1 story"
     And I should see a short overview of the trip with a story but without tag
    When I fill in the tags for the ride
     And I submit the form
    Then I should not see "Missing tags for 1 story"

  Scenario: Show tag cloud for tags
    Given a hitchhiker called "flo"
     And "flo" logged 2 trips with a tagged ride "dangerous"
     And "flo" logged 1 trip with a tagged ride "adventurous"
    When I go to the profile page of flo
    Then I should see a tag cloud with "adventurous" and "dangerous"
