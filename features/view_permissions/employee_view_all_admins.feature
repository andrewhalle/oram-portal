Feature: As a central admin, I should see all admins
  As an employee, I should not see all admins
  I should see a warning, "You must be a central admin to do that"
  I should be redirected to the home page
  
Background:

  Given the following admins exist:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role     |
    | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test'                 | central |
    | Hannah		  | Montana   | hannah@montana.com	| oram123	  | 'test'                 | employee |
    | Hillary		  | Clinton	  | hillary@clinton.com	| oram123	  | 'test'                 | employee |
    | Adrian		  | Greenberg | adrian@greenberg.com| oram123	  | 'test'                 | employee |

  And I am logged in as the following admin: 
     | first_name  | last_name   | email                 | password     	  | role					| 
     | Donald		  | Trump		  | donald@trump.com		| oram123	  | employee            |

Scenario: employee checking the admins list page
  When I am on the admins list page
  Then I should not see "Hillary"
  And I should not see "Adrian"
  And I should be on the home page