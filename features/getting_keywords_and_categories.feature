Feature: As a user of the clinical library
  I want to retrieve keywords, categories, and terms from ClinicalTrials.gov
  So that I can associate related trials

  Scenario: Get keywords, categories, and terms
    When I attempt to retrieve keywords for trial "NCT00001372"
    Then it should have "keywords" like "Autoimmunity"
    And it should have "categories" like "Urologic Diseases"
    And I should have "terms" like "Connective Tissue Diseases"
