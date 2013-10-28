Feature: Create a Hen Party
  In order to organise a Hen Party
  As a Chief Hen
  I want to create a Hen Party

  Scenario: When I visit the app
    Given I am on the homepage
    When I click 'Create Hen Party'
    Then I should see a new Hen Party
