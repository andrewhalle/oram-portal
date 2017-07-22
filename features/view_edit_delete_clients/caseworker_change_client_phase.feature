Feature: Case Worker viewing client profiles and being able to approve/reject them
  As an ORAM Case Worker
  In order to mark client refugees statuses as approved, rejected, or incomplete
  I want to be able to see a table of all clients and be able to view their individual profiles

Background: Clients in the database and logged in as an Case Worker
  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role				| invitation_accepted_at | status |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | 'test'                 | Accepted   |
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 | Accepted   |
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 | Rejected   |
    | Joe         | Bob     	| joe@bob.com          | oram123            | client			  | 'test'                 | Approved   |

    And the following referrers exist:
    | first_name  | last_name   | email                 | password     	  | role				| invitation_accepted_at | status |
    | Alice       |Wonderland   | alice@wonderland.com  |oram123            | referrer          | 'test'            | Approved  |
    | Shawn       | Kingston    | shawn@kingston.com    | oram123           | referrer          | 'test         | Incomplete |
  
    And I am logged in as the following admin:
    | first_name  | last_name       | email                     | password          | role      |
    | oram        | caseworker     | case_worker321@gmail.com  | oram_case_worker  | employee  |
  
    And the following relations exist:
    | client      | caseworker      |
    | Bryan Adams | oram caseworker |
    | George Clooney | oram caseworker|
    
    And the following referrals exist:
    | referrer          | referral_name |
    | Alice Wonderland | George Clooney |

Scenario: Case Worker viewing the list of clients
  Given I follow "Clients"
  Then I should see "Bryan"
    And I should see "George"
    And I should not see "Michael"
    And I should not see "Joe"
    
Scenario: Caseworker should see the approved referrers but not unapproved referrers
    Given I follow "Referrers"
    Then I should see "Alice"
    And I should not see "Shawn"

Scenario: Caseworker should also see all the referrals
    Given I follow "Referrals"
    Then I should see "George"
    And I should not see "Michael"
    And I should not see "Alice"

