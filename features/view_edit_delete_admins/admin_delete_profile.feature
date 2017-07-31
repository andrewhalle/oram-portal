Feature: As an admin, I want to be able to delete my own profile.

Background:
  Given I am logged in as the following admin: 
    | first_name  | last_name   | email                 | password     	  | role					| 
    | Donald		  | Trump		  | donald@trump.com		| oram123	  | central          |

Scenario: Admin editting their own profile
  Given I follow "Settings"
  And I press "Delete Profile"
  Then I should be on the home page
  When I login as admin with email "donald@trump.com" and password "oram123"
  Then I should be on the admin login page