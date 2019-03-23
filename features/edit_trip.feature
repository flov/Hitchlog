Feature: User edits trip
  @edit_trip
  Scenario: Edit an existing trip
    Given I am logged in
    And I logged a trip
    When I visit the edit page of this trip
    And I fill in the following:
      | trip_departure_1i  (select) | 2014   |
      | trip_departure_2i  (select) | August |
      | trip_departure_3i  (select) | 3      |
      | trip_departure_4i  (select) | 10     |
      | trip_departure_5i  (select) | 00     |
      | trip_arrival_1i    (select) | 2014   |
      | trip_arrival_2i    (select) | August |
      | trip_arrival_3i    (select) | 3      |
      | trip_arrival_4i    (select) | 12     |
      | trip_arrival_5i    (select) | 00     |
    And I press "Update Trip"
    Then I should see "2 hours"

