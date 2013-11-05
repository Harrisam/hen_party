Feature: Hen signs out
  In order to keep my Hen Party private
  As a Hen
  I want to sign out

  Scenario: but not when signed out
    Given I am on the homepage
    Then I should not see "Sign out"

  Scenario: by visiting the welcome page
    Given I have an account
    And I have signed in
    When I click "Sign out"
    Then I should be on the sign in page
    And I should be signed out