Feature: As a potential participant for a clinical study
  I want to search for clinical trials
  So that I can find out more information about them

Scenario: Find open studies
  Given I am searching for trials where "recruiting" is "open"
  When I perform the search
  Then I should get trials with the "status" of "recruiting" or "not_yet_recruiting"

