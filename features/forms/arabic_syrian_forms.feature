Feature: Arabic speaking client checking their questionnaire
  As a client who prefers Arabic (syrian) as a language
  I should have an Arabic questionnaire and respective syrian forms. 

Background: client in the database
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role		   	  | languages | country              |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | Arabic    | Syrian Arab Republic |

Scenario: Viewing Arabic Client Forms
    Given pending
    Given I follow "Profile"
    Then I should see "Questionnaire status: Complete"

Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Download Link"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: Arabic (syrian)"
  
Scenario: Ensuring the non syrian designation is assigned properly
  Given Pending
  Given I follow "Profile"
    And I press "Questionnaire"
    Then I should see "Preferred Language: Arabic (syrian)"
  
Scenario: Ensuring the non syrian designation is assigned properly
  Given I follow "Profile"
    And I follow "Edit"
    And I press "Submit"
    And I follow "Settings"
    And I follow "Documents"
    Then I should see "3)ORAM_Client_in_take_Form[Arabic].pdf"
  
Scenario: Sending correct form based on language preference (Arabic (syrian) in this case)
  Given pending
  Given I follow "Profile"
    And I press "Questionnaire"
  Then I should see "Arabic (syrian) Questionnaire"
  Given I follow "Profile"
  Then I should see "Arabic: good"
    And I see "Farsi: okay"