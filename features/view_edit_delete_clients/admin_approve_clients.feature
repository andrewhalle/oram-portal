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

Scenario: Admin trying to mark statuses of clients
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
  And I press "Approve"
  Then the status of "Bryan Adams" should be "Approved"
  And I view the profile of "George Clooney"
  And I press "Reject"
  Then the status of "George Clooney" should be "Rejected"
  And I view the profile of "Michael Jordan"
  And I press "Incomplete"
  Then the status of "Michael Jordan" should be "Incomplete"

Scenario: Admin trying to edit client profile 
  Given Pending
  Given I follow "Clients"
  And I view the profile of "Joe Bob"
  And I press "Edit Profile"
  Then I should be on the edit profile page

Scenario: Admin trying to delete client profile
  Given Pending
  Given I follow "Clients"
  And I view the profile of "Michael Jordan"
  And I press "Delete Profile"
  And I go back to the clients page
  Then I should not see "Michael Jordan"
