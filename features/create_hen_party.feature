Feature: Create a Hen Party
  In order to organise a Hen Party
  As a Chief Hen
  I want to create a Hen Party

  Scenario: When I visit the app
    Given I am on the homepage
    When I click "Create Hen Party"
    Then I should be on the new hen party page

  Scenario: with valid details
    Given I am on the new hen party page
    When I submit the new hen party form with valid details
    Then I should see a welcome message
    And I should be on my hen party page
