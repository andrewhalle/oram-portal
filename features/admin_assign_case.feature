Feature: Central Admin assigning clients to caseworkers
  As a central admin
  In order to assign clients to caseworkers
  I want to see an option to assign clients to caseworkers on the clients page
  I want to see an option to move clients to the next phase
  
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

Scenario: Adding a client to a caseworkers
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
  And I select "Anna Karenina" from the caseworker dropdown
  And I press "Assign Caseworker"
  Then I should be on the profile page of user "Bryan Adams"
  And I should see "Caseworkers: Anna Karenina"
  Given I follow "Admins"
  And I view the profile of "Anna Karenina"
  And I should see "Clients: Bryan Adams"
  
Scenario: Removing a client from a caseworker
  Given pending
  Given I follow "Clients"
    And "Sam Iam" is a Caseworker of "George Clooney"
    And "Andrew Wood" is a Caseworker of "George Clooney"
  Then I view the profile of "George Clooney"
  And I remove "Sam Iam" as a Caseworker from "George Clooney"
  Then I should not see "Sam Iam"
  And "Andrew Wood" should be a Caseworker of "George Clooney"
  