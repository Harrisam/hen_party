Feature: Chief Hen signs up
  In order to make my Hen Party private
  As a Chief Hen
  I want to sign up for Hen Party app

  Scenario: by visiting the welcome page
    Given I am on the homepage
    When I click "Sign up"
    Then I should be on the sign up page

  Scenario: with valid details
    Given I am on the sign up page
    When I submit the sign up form with valid details
    Then I should be signed in
    And I should see a welcome message
