Feature: Invite Hens to the party
  In order to invite Hens to my hen party
  As a Chief Hen
  I want to send them an email link to my hen party

  Scenario: when I have added Hens to my party
    Given I have a party with some hens
    When I click "Invite Hens"
    Then I should be on the new invitation page
