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
    Given I am searching for trials where "outcome" is "toxic"
    When I perform the extended search
    Then I should get trials where the "outcomes" contains "toxic"

  Scenario: Find a specific sponsor
    Given I am searching for trials where "sponsor" is "Eli Lilly"
    When I perform the extended search
    Then I should get trials where the "sponsors" contains "Eli Lilly"

  Scenario: Find a specific trial
    When I attempt to retrieve trial "NCT00001372"
    Then I should get a trial
    And the trial should have an "id" of "NCT00001372"

  Scenario: Find a specific trial with extended attributes
    When I attempt to retrieve trial "NCT00454363"
    Then I should get a trial
    And the trial should have a "phase" of "2"
    And the trial should have "conditions" like "Lung Cancer"
    And the trial should have a "minimum_age" of "21 Years"
    And the trial should have "sponsors" like "M.D. Anderson"
    And the trial should have an "overall_official" like "Alexandra Phan, MD"

  Scenario: Find trials that were updated between a range of dates
    Given I am searching for trials that have been updated between "07/06/2009" and "07/07/2009"
    When I perform the extended search
    Then I should get trials where "updated_at" is greater than or equal to "07/06/2009" 
    And I should get trials where "updated_at" is less than or equal to "07/07/2009"

  Scenario: Find trials that were updated beyond a single date
    Given I am searching for trials that have been updated after "07/06/2009"
    When I perform the extended search
    Then I should get trials where "updated_at" is greater than or equal to "07/06/2009"

  Scenario: Find a non-existant trial
    When I attempt to retrieve trial "4325785"
    Then I should not get a trial
    
