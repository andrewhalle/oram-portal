Feature: Central Admin removing clients from caseworkers
  As a central admin
  In order to remove clients from caseworkers
  I want to see an option to remove caseworkers from clients on the clients page
  I want to see an option to remove clients from caseworkers on the caseworker page
  
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

Scenario: Removing a caseworker from a client on the client profile page
    Given I am on the profile page of user "Michael Jordan"
    And I assign caseworker "Anna Karenina" to client "Michael Jordan"
    And I view "Caseworkers"
    And I should see "Anna Karenina"
    And I remove caseworker "Anna Karenina" from client "Michael Jordan"
    Then "Anna Karenina" should not be a caseworker of client "Michael Jordan"
    
Scenario: Removing a client from a caseworker on the caseworker profile page
    Given pending
    Given I am on the profile page of admin "Andrew Wood"
    And I assign caseworker "Andrew Wood" to client "Michael Jordan"
    And I remove client "Michael Jordan" from caseworker "Andrew Wood"
    Then "Andrew Wood" should not be a caseworker of client "Michael Jordan"
    When I am on the caseworker tab of "Michael Jordan"
    Then I should not see "Anna Karenina"
    When I am on the status feed tab of "Michael Jordan"
    Then I should see "oram admin removed client Michael Jordan from Caseworker Andrew Wood"