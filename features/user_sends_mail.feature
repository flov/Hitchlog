Feature: Send mails
  Scenario:
    Given I am logged in as "Flov"
    And a hitchhiker called "Supertramp"
    When I visit the profile page of "Supertramp"
    And I follow "Send Mail"
    And I fill in "Message body" with "test message"
    And I press "Send Mail"
    Then I should be on the profile page of Supertramp
    And a mail should have been delivered to "Supertramp"
    And I should see "Mail has been sent to Supertramp"

