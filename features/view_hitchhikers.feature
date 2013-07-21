Feature: Display all Hitchhikers
  @hitchhikers
  Scenario: two hitchhikers in database
    Given 2 hitchhikers
    When I go to the hitchhikers page
    Then I should be able to see both hitchhikers
