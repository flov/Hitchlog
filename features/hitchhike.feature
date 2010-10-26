Feature: Hitchhike feature
  In order to post hitchhikes
  A user
  Should be able upload a photo and tell from where to where he went.

  Scenario: User creates hitchhike with invalid data
    When I go to the new hitchhike page
    And I fill in the following:
      | Title | example   |
    And I press "Submit"
    Then I should see error messages

  Scenario: User creates hitchhike with valid data and a Photo
    When I go to the new hitchhike page
    And I fill in the following:
      | Title   | Trip in eastern Europe |
      | From    | Belgrade               |
      | To      | Odessa                 |
    And I attach the file "features/support/cucumber.jpg" to "Photo"
    And I press "Submit"
    Then I should see "Crop the photo"

  Scenario: User creates hitchhike with valid data without a Photo
    When I go to the new hitchhike page
    And I fill in the following:
      | Title   | Trip in eastern Europe |
      | From    | Belgrade               |
      | To      | Odessa                 |
    And I press "Submit"
    Then I should see "Successfully created hitchhike."