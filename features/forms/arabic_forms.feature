 Scenario: Viewing Arabic Client Forms
    Given I follow "Profile"
    Then I should see "Questionnaire status"
    
Background: Client in the database
  Given I am logged in as the following client:
    Given pending
    | first_name  | last_name   | email                 | password     	  | role		   	  | farsi | arabic  | english |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | okay  | good    | okay    |

Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Case Document"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  Then I should see "Preferred Language: Arabic"
  
Scenario: Checking if form is sent properly to Farsi speaking clients
  Given pending
  Given I follow "Profile"
  Then I should see "Complete"
    And I press "Questionnaire"
  Then I should see "Arabic Questionnaire"
  
Scenario: Sending correct form based on language preference (Farsi in this case)
  Given pending
  Given I follow "Profile"
  Then I should see "Arabic Questionnaire"  
    And I press "Arabic Questionnaire"
  Then I should see "Arabic: good"
    And I see "Farsi: okay"
  