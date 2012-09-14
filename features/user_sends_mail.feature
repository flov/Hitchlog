Feature: Send mails
  Scenario:
    Given I am logged in
    And a hitchhiker called "Supertramp"
    When I go to the profile of "supertramp"
    And I follow "Send Mail"
    And I fill in "Message body" with "test message"
    And I press "Send Mail"
    Then I should be on the profile of "supertramp"
    And a mail should have been delivered to "Supertramp"
    And I should see "Mail has been sent to Supertramp"

