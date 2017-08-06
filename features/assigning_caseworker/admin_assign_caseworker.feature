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

Scenario: Assigning a caseworker to a client
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
  And I view "Caseworkers"
  And I select "Anna Karenina" from the caseworker dropdown
  And I press "Assign Caseworker"
  Then I should be on the profile page of user "Bryan Adams"
  And I view "Caseworkers"
  And I should see "Anna Karenina"
  And I should see "Bryan Adams has been assigned to caseworker Anna Karenina"
  Given I follow "Admins"
  And I view the profile of "Anna Karenina"
  And I should see "Clients: Bryan Adams"

Scenario: Assigning multiple clients to a caseworker
  Given I assign caseworker "Anna Karenina" to client "Bryan Adams"
  And I follow "Clients"
  And I view the profile of "George Clooney"
  And I should see "User George Clooney created an account."
  And I assign caseworker "Anna Karenina" to client "George Clooney"
  And I should see "George Clooney has been assigned to caseworker Anna Karenina"
  And I should see "Anna Karenina"
  Given I follow "Admins"
  And I view the profile of "Anna Karenina"
  And I should see "Bryan Adams"
  And I should see "George Clooney"
  
Scenario: Assigning multiple caseworkers to a client
  Given I assign caseworker "Sam Iam" to client "Bryan Adams"
  Then I should see "Bryan Adams has been assigned to caseworker Sam Iam"
  And I assign caseworker "Anna Karenina" to client "Bryan Adams"
  Then I should see "Anna Karenina"
  Given I follow "Admins"
  And I view the profile of "Anna Karenina"
  And I should see "Clients: Bryan Adams"

Scenario: Assigning the same caseworker to a client twice shouldn't duplicate
  Given I assign caseworker "Anna Karenina" to client "Bryan Adams"
  And I assign caseworker "Sam Iam" to client "Bryan Adams"
  And I assign caseworker "Anna Karenina" to client "Bryan Adams"
  Then I should see "Bryan Adams has been assigned to caseworker Sam Iam"
  And I should see "Anna Karenina"
  And I should not see "Anna Karenina,Sam Iam,Anna Karenina"
  Given I follow "Admins"
  And I view the profile of "Anna Karenina"
  And I should see "Clients: Bryan Adams"
  And I should not see "Clients: Bryan Adams,Bryan Adams"

Scenario: A caseworker without clients should show as having no clients
  Given I follow "Admins"
  And I view the profile of "Sean Kingston"
  Then I should see "This caseworker has no clients"

  