Feature: Central Admin marking status of different forms generates an event
  As a central admin
  In order to mark the forms of referrals, referrers, and client questionnaires
  I want to mark forms
  I want to see an event that tracks form status 
  
Background: Logging in as an Admin
  
    Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role			  | invitation_accepted_at |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | 'test'                 |
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 |
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 |
    | Joe         | Bob     	| joe@bob.com           | oram123         | client			  | 'test'                 |
    
    And the following admins exist:
    | first_name  | last_name   | email                 | password     	  | role			  |
    | Andrew      | Wood     	| andrew@wood.com       | oram123         | central			  |
    | Sean        | Kingston    | Sean@Kingston.com     | oram123         | central			  |
    | Anna        | Karenina	| Anna@karenina.com     | oram123         | employee		  |
    | Sam         | Iam     	| Sam@Iam.com           | oram123         | employee		  |
    
    And I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central |

Scenario: Admin changes status of a client questionnaire.
    Given pending
    Given I approve client "George Clooney"