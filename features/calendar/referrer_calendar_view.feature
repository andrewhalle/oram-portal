Feature: Referrer changing and addting to Client's calendars
  As a Referrer
  I want to be able see all the respective calendars of clients under me. I also want to be able to view their events.

Background: Logging is an an Referrer to check calendars
  Given pending
  Given that I am logged in as the following Referrer:
    | first_name	| last_name	     | email               | password	| role        |
    | Person	    | Referrer       | referrer@user.com   | password   | referrer    |

  Given the following clients exist:
    Given pending
    | first_name  | last_name   | email                 | password     	  | role			 | referrer |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client	         | Person   |

  Given the following admins exist:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
    | Central	    | Admin       | central@admin.com   | password	| 'test'               | central     |

  Given the following events exist:
    | title | do-by date | assigned by | 
    | complete questionnaire | 1/1/2025 | Central Admin |

Scenario: Referrer viewing an event on a client's calendar
  Given pending
  Given I follow "Referrals"
  When I press "View Profile"
  Then I should see "Calendar"
    And I should see "complete questionnaire"
    And I press "complete questionnaire"
  Then I should see "Central Admin"
    And I should see "1/1/2025"