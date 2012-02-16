Feature: Show all trips
  Scenario: sort trips by country
    Given a German trip exists
    And an English trip exists
    When I go to the trips page
    Then I should see a German trip
    And I should see an English trip
    When I search for German trips
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
