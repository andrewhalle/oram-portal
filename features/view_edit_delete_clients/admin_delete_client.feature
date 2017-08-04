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

  Given the following admins exist:
    | first_name | last_name | email              | password | role        |
    | central    | admin     | central@admin.com  | password | central     |
    | employee   | admin     | employee@admin.com | password | employee    |
  
  And I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central  |

Scenario: central admin deletes user
  Given I am on the profile page of user "Bryan Adams"
  And I press "Delete User"
  Then I should be on the clients list page
  And I should not see "Bryan"
  When I go to the home page
  Then I should see "Bryan Adams deleted"

Scenario: employee admin tries to delete user
  Given I follow "Sign out"
  And I am logged in with credentials "employee@admin.com" and "password"
  And I am on the profile page of user "Bryan Adams"
  Then I should not see "Delete User Account"