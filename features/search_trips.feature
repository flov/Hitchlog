Feature: Search trips
  Scenario: sort trips by country
    Given a German trip exists
    And an English trip exists
    When I go to the trips page
    Then I should see a German trip
    And I should see an English trip
    When I search for "Germany" trips
    Then I should see a German trip
    And I should not see an English trip

  Scenario: sort trips by stories
    Given a trip with a story
    And a trip without a story
    When I go to the trips page
    Then I should see a trip with a story
    And I should see a trip without a story
    When I search for trips with stories
    Then I should see trips with stories
    And I should not see trips without stories

  Scenario: sort trips by experience
    Given 6 trips exist with a different experience respectively
    When I go to the trips page
    And I search for trips with a "good" experience
    Then I should see a trip with an "good" experience
    And I should not see a trip with a "bad" experience
