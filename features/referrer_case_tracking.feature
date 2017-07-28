Feature: Referrer viewing client profiles and being able to approve/reject them
  As an ORAM referrer
  I want to be able to see a a client case status

Background: Clients in the database and logged in as an Case Worker
  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role			    | invitation_accepted_at |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client		    | 'test'                 |
    | George      | Clooney     | george@clooney.com    | oram123         | client			  | 'test'                 |
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client			  | 'test'                 |
    | Joe         | Bob     	  | joe@bob.com           | oram123         | client			  | 'test'                 |

  And I am logged in as the following referrer:
    | first_name  | last_name                       | email                     | password         | role     |
    | oram        | Case Worker                     | Case Worker321@gmail.com  | oramCase Worker  | referrer |

Scenario: A referrer checking a client status
  Given pending
  Given I follow "Case Status"
  Then the status of "Bryan Adams" should be "Approved"
  And the status of "George Clooney" should be "Rejected"
  And the status of "Michael Jordan" should be "Incomplete"
