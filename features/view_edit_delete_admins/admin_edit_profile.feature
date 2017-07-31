Feature: As an admin, I want to be able to edit my own profile.

Background:
  Given I am logged in as the following admin: 
    | first_name  | last_name   | email                 | password     	  | role					| 
    | Donald		  | Trump		  | donald@trump.com		| oram123	  | central          |

Scenario: Admin editting their own profile
  Given I follow "Settings"
  And I press "Edit Profile"
  Then I should be on the admin settings edit page of admin "Donald Trump"
  When I change my "Phone" to "1234567890"
  And I press "Update Admin"
  Then I should be on the admin settings page of admin "Donald Trump"
  When I follow "Profile"
  Then I should see "1234567890"