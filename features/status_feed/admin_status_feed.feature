Feature: Central Admin checking the status of clients via the status feed.
  As an ORAM administrator
  I want to be able to see a status feed on the landing page that displays the status of all referrers and prospective clients.

Background: Logging is an an Admin to check statuses
  Given I am logged in as the following admin
    | first_name | last_name | email          | password | role    |
    | central    | admin     | admin@test.com | password | central |

  Given the following clients exist:
  Given pending  
    | first_name  | last_name   | email                 | password     	  | role			    | invitation_accepted_at | 
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | referrer	    | 'test'                 | 
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 |
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 |
    | Joe         | Bob        	| joe@bob.com           | oram123         | client			  | 'test'                 | 

Scenario: Checking if CASF (Central Admin Status Feed) exists 
  Given PENDING
  Given I am on the home page 
  Then I should see "Latest"
    And I should see "Joe Bob"
    And I should see "User Joe Bob created an account"
      
Scenario: Checking if CASF (Client Approval Status Feed) exists 
  Given PENDING
  Given I am on the home page 
  Then I shoulds ee "Client Approval Status Feed"
    And I should see "Bryan Adams"
    And I should see "Approved"
    And I should see "Michael Jordon"
    And I should see "Rejected"