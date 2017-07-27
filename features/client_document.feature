Feature: Client document
  As a client looking for refugee status
  In order for an administrator to consider me for refugee status
  I want to be able to upload a document with necessary information that the administrators can review

Background: Client in the database
  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role					|
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  |

Scenario: Viewing Case Document
  Given I follow "Documents"
  Then I should see "Case Document"

Scenario: Ensuring the client's country of origin is accounted for 
  Given Pending
  Given I follow "Profile"
  And I press "Questionnaire"
  Then I should see "Country of Origin:"
  
Scenario: Checking if the form's language matches the client's country of origin (non-syrian Arabic Speaking)
  Given pending
  Given I follow "Profile"
  And I press "Questionnaire"
  Then I should see "good"
  Given I follow homepage 
  Then I should see "Arabic form sent to user"
  
Scenario: Checking if form is sent properly to Farsi speaking clients
  Given pending
  Given I follow "Profile"
  And I press "Questionnaire"
  Then I should see "Farsi: good"
  Given I follow homepage
  Then I should see "Farsi form sent to user"
  
Scenario: Sending correct form based on language preference (Farsi in this case)
  Given pending
  Given I follow "Profile"
  And I press "Questionnaire"
  Then I should see "Farsi: good"
    And I see "Arabic: okay"
  Given I follow homepage
  Then I should see "Farsi form sent to user"
  
  