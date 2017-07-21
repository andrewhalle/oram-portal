Feature: referrer signing up is not granted Admin access
  As a registered referrer
  I should not have the same privileges as an admin
  
Scenario: logged in referrer doesn't have admin access
  Given that I am logged in as the following referrer:
    | first_name	  | last_name	| email             	  | password	| invitation_accepted_at | role        |
    | Bryan         | Adams     | bryan@adams.com       | oram123	  | 'test'                 | referrer    |
  Then I should not have admin access
  
Scenario: signup with profile attributes
  Given that I am on the signup page
  Then I should see Phone
  And I should see Skype
  And I should see Address