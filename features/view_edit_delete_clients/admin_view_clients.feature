Feature: Administrator viewing client profiles and being able to approve/reject them
  As an ORAM administrator
  In order to mark client refugees statuses as approved, rejected, or incomplete
  I want to be able to see a table of all clients and be able to view their individual profiles

Background: Clients in the database and logged in as an admin
  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role					| invitation_accepted_at | phase    |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | 'test'                 | "Phase 1"|
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 | "Phase 3"|
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 | "Phase 4"|
    | Joe         | Bob     	  | joe@bob.com           | oram123         | client			  | 'test'                 | "Phase 5"|

  And I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central  |

Scenario: Admin viewing the list of clients
  Given I follow "Clients"
  Then I should see "Bryan"
  Then I should see "George"
  Then I should see "Michael"
  Then I should see "Joe"
  And the phase of "Michael Jordan" should be "Phase 4"
  And the phase of "George Clooney" should be "Phase 3"
  And the phase of "Bryan Adams" should be "Phase 1"