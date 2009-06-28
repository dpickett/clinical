Feature: As a potential participant for a clinical study
  I want to search for clinical trials
  So that I can find out more information about them

  Scenario: Find open studies
    Given I am searching for trials where "recruiting" is "true"
    When I perform the search
    Then I should get trials that are "open"

  Scenario: Find closed studies
    Given I am searching for trials where "recruiting" is "false"
    When I perform the search
    Then I should get trials that are not "open"

  Scenario: Find a specific condition
    Given I am searching for trials where "condition" is "hemophelia"
    When I perform the extended search
    Then I should get trials where the "conditions" contains "hemophelia"

  Scenario: Find a specific intervention
    Given I am searching for trials where "intervention" is "drug"
    When I perform the extended search
    Then I should get trials where the "interventions" contains "drug"

  Scenario: Find a specific outcome
    Given I am searching for trials where "outcome" is "decreased toxicity"
    When I perform the extended search
    Then I should get trials where the "outcomes" contains "decreased toxicity"

  Scenario: Find a specific sponsor
    Given I am searching for trials where "sponsor" is "Eli Lilly"
    When I perform the extended search
    Then I should get trials where the "sponsors" contains "Eli Lilly"

  Scenario: Find a specific trial
    When I attempt to retrieve trial "NCT00001372"
    Then I should get a trial
    And the trial should have an "id" of "NCT0001372"

  Scenario: Find a non-existant trial
    When I attempt to retrive trial "4325785"
    Then I should not get a trial
    
