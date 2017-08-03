Feature: Client view of their own event calendar 
  As an ORAM client
  I want to be able see events related to me on my calendar. I also want to be able to
  view the details of events through the calendar.

Background: Logging is an an client to check my calendar
  Given pending
  Given that I am logged in as the following client:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
    | ORAM	    | Client       | client@user.com   | password	| 'test'                 | client     |

  Given pending
  Given the following admins exist:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
    | Central	    | Admin       | central@admin.com   | password	| 'test'               | central     |

  Given pending
  Given the following events exist:
    | title | do-by date | assigned by | 
    | complete questionnaire | 1/1/2025 | Central Admin |

Scenario: making sure the questionnaire is marked as incomplete 
  Given pending 
  Given I follow "Profile"
  Then I should see "Questionnaire status: Incomplete"
  
Scenario: viewing an event on client calendar
  Given pending
  Given I follow "Profile"
  Then I should see "Calendar"
  When I press "complete questionnaire"
  Then I should should see "Questionnaire"