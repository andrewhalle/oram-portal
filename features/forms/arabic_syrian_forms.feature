Feature: Arabic speaking client checking their questionnaire
  As a client who prefers Arabic (syrian) as a language
  I should have an Arabic questionnaire and respective syrian forms. 

Background: client in the database
  Given pending
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role		   	  | farsi | arabic  | english |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | okay  | good    | okay    |

Scenario: Viewing Arabic Client Forms
    Given pending
    Given I follow "Profile"
    Then I should see "Questionnaire status: Complete"

Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Case Document"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: Arabic (syrian)"
  
Scenario: Ensuring the non syrian designation is assigned properly
  Given Pending
  Given I follow "Profile"
    And I press "Questionnaire"
    Then I should see "Preferred Language: Arabic (syrian)"
  
Scenario: Checking if form is sent properly to Farsi speaking clients
  Given pending
  Given I follow "Profile"
  Then I should see "Complete"
    And I press "Questionnaire"
  Then I should see "ORAM Engagement Agreement SYRIANS [English & Arabic].pdf"
  
Scenario: Sending correct form based on language preference (Arabic (syrian) in this case)
  Given pending
  Given I follow "Profile"
    And I press "Questionnaire"
  Then I should see "Arabic (syrian) Questionnaire"
  Given I follow "Profile"
  Then I should see "Arabic: good"
    And I see "Farsi: okay"