Feature: Search Users
  Scenario: Search by username
    Given a hitchhiker called "flov"
    And a hitchhiker called "flohfish"
    And a hitchhiker called "malte"
    When I go to the users page
    And I search for "flo" by username
    Then I should see "Flov"
    And I should see "Flohfish"
    And I should not see "Malte"

  Scenario: Search by location
    Given a hitchhiker from "Melbourne"
    And a hitchhiker from "Berlin"
    When I go to the users page
    And I search for "Melbourne" by location
    Then I should see "Melbourne"
    And I should not see "Berlin"
