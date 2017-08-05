Feature: Clients viewing their own caseworkers
  Clients should see all their caseworkers
  Clients should not be able to delete caseworkers
  Clients should not be able to assign caseworkers
    
Background:
    Given the following admins exist:
    | first_name  | last_name   | email                 | password     	  | role			  |
    | Andrew      | Wood     	| andrew@wood.com       | oram123         | central			  |
    | Sean        | Kingston    | Sean@Kingston.com     | oram123         | central			  |
    | Anna        | Karenina	| Anna@karenina.com     | oram123         | employee		  |
    | Sam         | Iam     	| Sam@Iam.com           | oram123         | employee		  |
    
    And I am logged in as the following client:
    | first_name  | last_name | email               | password   | role     |
    | Alice       | Wonderland   | client321@gmail.com  | oramclient  | client |
    
    And the following relations exist:
    | client    | caseworker|
    | Alice Wonderland | Andrew Wood |
    | Alice Wonderland | Sam Iam |
    | Alice Wonderland | Sean Kingston |

Scenario: Client views their own caseworkers
  Given I view the caseworker tab of "Alice Wonderland"
  Then I should see "Andrew Wood"
  And I should see "Sam Iam"
  And I should see "Sean Kingston"
  And I should not see "Karenina"

Scenario: Clients should not be able to assign caseworkers
  Given I view the caseworker tab of "Alice Wonderland"
  Then there should not be the caseworker dropdown