Feature: English speaking client checking their questionnaire
  As a client who prefers English as a language
  I should have an English questionnaire
  
    
Background: client in the database
  Given pending
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role		   	  | farsi | arabic  | english |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | okay  | okay    | good    |

Scenario: Viewing English Client Forms
    Given pending
    Given I follow "Profile"
    Then I should see "Questionnaire status"
    
Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Case Document"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: English"
  
Scenario: Checking if form is sent properly to Farsi speaking clients
  Given pending
  Given I follow "Profile"
  Then I should see "Complete"
    And I press "Questionnaire"
  Then I should see "English Questionnaire"
  
Scenario: Sending correct form based on language preference (Farsi in this case)
  Given pending
  Given I follow "Profile"
  Then I should see "English Questionnaire"  
    And I press "English Questionnaire"
  Then I should see "English: good"
    And I see "Farsi: okay"
  