@javascript
Feature: Admin should be able to correctly change their password
  As an admin, I want to be able to change my password
  I want to log in with this new password
  I want to not be able to log in with the past password
  
Background:
  Given I am logged in as the following admin: 
    | first_name  | last_name   | email                 | password     	  | role					| 
    | Donald		  | Trump		  | donald@trump.com		| oram123	  | central          |  

Scenario: Admin changes their password and logs in with new password
  Given I follow "Settings"
  And I press "Change Password"
  Then I should be on the change password page of admin "Donald Trump"
  And I fill in "admin_encrypted_password" with "oram123"
  And I fill in "admin_pass_reset1" with "newpassword"
  And I fill in "admin_pass_reset2" with "newpassword"
  And I press "Update Admin"
  Then I should be on the admin login page

Scenario: Admin changes their password and logs in with old password
  Given I change my password from "oram123" to "newpassword"
  When I login as admin with email "donald@trump.com" and password "oram123"
  Then I should be on the admin login page
  When I login as admin with email "donald@trump.com" and password "newpassword"
