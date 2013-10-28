Feature: User signs up
  In order to make my Hen Party private
  As a Chief Hen
  I want to sign up for Hen Party app

  Scenario: by visiting the welcome page
    Given I am on the homepage
    When I click "Sign up"
    Then I should be on the sign up page
    