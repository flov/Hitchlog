Feature: User manages trips
  In order to keep my trips up to date
  As a user
  I want to add/edit and view my own trips

  Scenario: Log new trip
    Given I am logged in 
    And I go to the new trip page
    When I fill in the following:
      | From                       | Berlin           |
      | To                         | Hamburg          |
      | Departure                  | 07/12/2011 10:00 |
      | Arrival                    | 07/12/2011 20:00 |
      | Number of rides            | 1                |
      | Traveling with    (select) | alone            |
    And I press "Continue"
    Then I should see "Edit Trip"

  #@wip
  #Scenario: Edit trip
    #Given I am logged in as "Flov"
    #And a trip exists
      #| From                   | Berlin           |
      #| To                     | Hamburg          |
      #| Departure              | 07/12/2011 10:00 |
      #| Arrival                | 07/12/2011 20:00 |
      #| Number of rides        | 1                |
      #| Travelling             | Alone            |
    #When I go to the edit profile page of this trip

