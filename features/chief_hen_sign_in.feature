Feature: Chief Hen signs in
  In order to see my private Hen Party
  As a Chief Hen
  I want to sign in

  Scenario: by visiting the welcome page
    Given I am on the homepage
    When I click "Sign in"
    Then I should be on the sign in page

  Scenario: with valid details
    Given I have signed up
    And I am on the sign in page
    When I submit the sign in form with valid details
    Then I should be logged in
    And I should see a welcome back message