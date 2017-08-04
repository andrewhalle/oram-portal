Feature: Caseworker changing and addting to Client's calendars
  As an ORAM caseworker
  I want to be able see all the respective calendars of clients assigned to me. I also want to be able to add new events 
  and edit existing events that are on them.

Background: Logging is an an caseworker to check calendars
  Given pending
  Given that I am logged in as the following caseworker:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role           |
    | employee	    | Admin     | employee@admin.com   | password	| 'test'                 | caseworker     |

  Given pending
  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role	    | 
    | John       | Adams     	| bryan@adams.com       | oram123         | client	    | 
    | George      | Clooney     | george@clooney.com    | oram123         | client	    | 
    | Michael     | Jordan    	| michael@jordan.com    | oram123         | client   	| 
    | Joe         | Bob      	| joe@bob.com           | oram123         | client		|

  Given pending
  Given the following events exist:
    | title | do-by date | assigned by | 
    | complete questionnaire | 1/1/2025 | Central Admin |

Scenario: caseworker viewing an event on a client's calendar
  Given pending
  Given I follow "Clients"
  When I press "View Profile"
  Then I should see "Calendar"
  Then I should not see "incomplete questionnaire"
  Then I should see "complete questionnaire"
    And I press "complete questionnaire"
  Then I should see "Central Admin"
      And I should see "1/1/2025"
  
Scenario: caseworker adding an event to a client's calendar
  Given pending
  Given I follow "Clients"
  When I press "View Profile"
  Then I should see "Calendar"
  When I press "Add event"
    And I fill out the title with "This is a test event"
  And I click "Add event"
  Then I should see "This is a test event"