Feature: Hitchhike feature
  In order to post hitchhikes
  A user
  Should be able post a hitchhike

  Scenario: User creates hitchhike with invalid data
    When I go to the new hitchhike page
    And I fill in the following:
      | Title | example   |
    And I press "Submit"
    Then I should see error messages
    

  Scenario: User creates hitchhike with valid data
    When I go to the new hitchhike page
    And I fill in the following:
      | Title   | Trip in eastern Europe |
      | From    | Belgrade               |
      | To      | Odessa                 |
      | Mission | get a life             |
    And I press "Submit"
    Then I should see "Successfully created hitchhike"
