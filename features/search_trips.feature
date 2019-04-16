Feature: Search trips
  Scenario: sort trips by experience
    Given 6 trips exist with a different experience respectively
    When I go to the trips page
    And I search for trips with a "good" experience
    Then I should see a trip with an "good" experience
    And I should not see a trip with a "bad" experience
