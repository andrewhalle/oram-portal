Feature: User Changing Password
  As a client
  I want to be able to change my password

Background: Logging in as a client with an account

  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role					| phase   |
    | Donald       | Trump     	| donald@trump.com       | oram123         | client			  | Phase 1 |

Scenario: Changing password should let me log in with new password
  Given I follow "Settings"
  And I press "Change Password"
  Then I should be on the change password page of user "Donald Trump"
  And I fill in "user_encrypted_password" with "oram123"
  And I fill in "user_pass_reset1" with "newpassword"
  And I fill in "user_pass_reset2" with "newpassword"
  And I press "Update User"
  Then I should be on the home page
  
Scenario: user changes their password and logs in with old password
  Given I change my password from "oram123" to "newpassword" as user
  Then I should be on the home page
  When I login as user with email "donald@trump.com" and password "oram123"
  Then I should be on the login page
  When I login as user with email "donald@trump.com" and password "newpassword"

Scenario: user tries to change password with password under 5 characters
  Given I change my password from "oram123" to "cat" as user
  Then I should be on the settings page of user "Donald Trump"

Scenario: user tries to change password with passwords that don't match
  Given I follow "Settings"
  And I press "Change Password"
  Then I should be on the change password page of user "Donald Trump"
  And I fill in "user_encrypted_password" with "oram123"
  And I fill in "user_pass_reset1" with "newpassword"
  And I fill in "user_pass_reset2" with "badpassword"
  And I press "Update User"
  Then I should be on the settings page of user "Donald Trump"

Scenario: user tries to change password with incorrect old password
  Given I change my password from "incorrectpassword" to "password" as user
  Then I should be on the settings page of user "Donald Trump"