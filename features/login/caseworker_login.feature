@javascript
Feature: Case Worker Login Portal
  As a user with Case Worker access to the ORAM portal
  In order to view all case documents
  I should be able to login under my user profile

Background: Case Worker in the database
  Given the following Case Workers exist:
    | first_name  | last_name | email               | password   |
    | oram        | Case Worker     | Case Worker321@gmail.com  | oramCase Worker  |

Scenario: Accessing the login page
  Given I am on the home page
  When I follow "Case Worker Sign In"
  Then I should be on the Case Worker login page
  And I should not see "Sign up"

Scenario: Valid Case Worker logging in
  Given I am on the Case Worker login page
  Then I should see "Case Worker Log in"
  When I fill in "Case Worker_email" with "Case Worker321@gmail.com"
  When I fill in "Case Worker_password" with "oramCase Worker"
  And I press "Log in"
  Then I should not see "Invalid Email or password."
  And I should be on the home page

Scenario: Case Worker login info does not exist
 Given I am on the Case Worker login page
 When I fill in "Case Worker_email" with "invalid_email"
 When I fill in "Case Worker_password" with "invalid_password"
 And I press "Log in"
 Then I should be on the Case Worker login page
 Then I should see "Invalid Email or password."

# Scenario: Case Worker should be able to view all case documents
#  Given I am on the Case Worker user profile page
#  When I press "All Cases"
#  Then I should see all case documents

# Scenario: Case Worker should be able to invite lawyers to view relevant cases
#  Given I am on the Case Worker user profile page
#  When I press "Invite Lawyers"
#  Then I should be on the invite lawyers page
