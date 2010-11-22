Feature: Hitchhike feature
  In order to post hitchhikes
  A user
  Should be able upload a photo and tell from where to where he went.

  Scenario: User creates hitchhike with invalid data
    Given I am logged in as flov
    When I go to the new hitchhike page
    And I fill in the following:
      | Title | example   |
    And I press "Submit"
    Then I should see error messages

  Scenario: Hitchhiker creates hitchhike with valid data and a Photo
    Given I am logged in as flov
    When I go to the new hitchhike page
    And I fill in the following:
      | Title   | Trip in eastern Europe |
      | From    | Belgrade               |
      | To      | Odessa                 |
    And I attach the file "features/support/cucumber.jpg" to "Photo"
    And I press "Submit"
    Then I should see "Crop the photo"

  Scenario: Hitchhiker creates hitchhike with valid data without a Photo
    Given I am logged in as flov
    When I go to the new hitchhike page
    And I fill in the following:
      | Title      | Trip in eastern Europe |
      | From       | Belgrade               |
      | To         | Odessa                 |
      | Story      | My Story               |
    And I press "Submit"
    Then I should see "Successfully created hitchhike."
    
    Scenario: 
      Given I am not logged in
      And I go to the new hitchhike page
      Then I should see "You need to sign in"