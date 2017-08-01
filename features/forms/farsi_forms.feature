Feature: Farsi speaking client checking their questionnaire
  As a client who prefers Farsi as a language
  I should have an Farsi questionnaire
  
    
Background: Client in the database
  Given pending
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role		   	  | farsi | arabic  | english |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | good  | okay    | okay    |

Scenario: Viewing Farsi Client Forms
    Given pending
    Given I follow "Profile"
    Then I should see "Questionnaire status"
    
Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Case Document"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: Farsi"
  
Scenario: Checking if form is sent properly to Farsi speaking clients
  Given pending
  Given I follow "Profile"
  Then I should see "Complete"
    And I press "Questionnaire"
  Then I should see "Farsi Questionnaire"
  
Scenario: Sending correct form based on language preference (Farsi in this case)
  Given pending
  Given I follow "Profile"
  Then I should see "Farsi Questionnaire"  
    And I press "Farsi Questionnaire"
  Then I should see "Farsi: good"
    And I see "Arabic: okay"
  