Feature: Farsi speaking client checking their questionnaire
  As a client who prefers Farsi as a language
  I should have an Farsi questionnaire
  
    
Background: Client in the database
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role		   	  | languages      | 
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | Persian/Farsi  | 

Scenario: Viewing Farsi Client Forms
    Given pending
    Given I follow "Profile"
    Then I should see "Questionnaire status"
    
Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Download Link"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: Farsi"
  
Scenario: Ensuring the non syrian designation is assigned properly
  Given I follow "Profile"
    And I follow "Edit"
    When I fill in "First Name" with "test"
    And I press "Submit"
    And I follow "Settings"
    And I follow "Documents"
    Then I should see "5)ORAM_Client_Claim_Guide_[Turkey].pdf"
  
Scenario: Sending correct form based on language preference (Farsi in this case)
  Given pending
  Given I follow "Profile"
  Then I should see "Farsi Questionnaire"  
    And I press "Farsi Questionnaire"
  Then I should see "Farsi: good"
    And I see "Arabic: okay"
  