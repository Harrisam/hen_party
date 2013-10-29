Feature: Hen Party access
  In order to keep my Hen Party private
  As a Chief Hen
  I want restrict access to my party

  Scenario: when not signed in
    Given I have an account
    When I try to access it
    Then I should be on the sign in page
  
  Scenario: when I am signed in
    Given I have an account
    And I have signed in
    When I try to access it
    Then I should be on my hen party page
