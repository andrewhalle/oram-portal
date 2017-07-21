Feature: ORAM Client checking the status of their application/case 
  As an ORAM Client
  I want to be able to see a status feed on the landing page that displays the current status of my application. 

Background: Logging is an a client 
  Given Pending
  Given that I am logged in as the following client:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role      | status   | status change |
    | Client	    | User      | client@user.com       | password	| 'test'                 | client    | approved | 072020179     |
  Given Pending
  Given that this client has the following status feed history:
    | status  | Update date |
    | pending | 07102017    |
    | applied | 06302017    |
  
Scenario: I want to check the status of my application 
  Given PENDING
  Given I am on the home page 
  Then I should see "Your application status"
    And I should see "approved"
    And I should see "072020179"
    And I press "View more"
  Then I should be on the application status page
    And I should see "pending"
    And I should see "07102017"