Feature: As a central admin, I should see all admins
  As a client, I should not see all admins
  I should see a warning, "You must sign in or sign up to continue"
  I should be redirected to the admin sign in page
Background:

  Given the following admins exist:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role     |
    | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test'                 | central |
    | Hannah		  | Montana   | hannah@montana.com	| oram123	  | 'test'                 | employee |
    | Hillary		  | Clinton	  | hillary@clinton.com	| oram123	  | 'test'                 | employee |
    | Adrian		  | Greenberg | adrian@greenberg.com| oram123	  | 'test'                 | employee |

  And I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role					| phase   |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | Phase 1 |

Scenario: client checking the admins page
  Given I am on the admins list page
  Then I should not see "Hillary"
  And I should not see "Adrian"
  Then I should be on the admin login page
