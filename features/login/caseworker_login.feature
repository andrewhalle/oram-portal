@javascript
Feature: Caseworker Login Portal
  As a user with Caseworker access to the ORAM portal
  In order to view all case documents
  I should be able to login under my user profile

Background: Case Worker in the database
  Given the following admins exist:
    | first_name  | last_name       | email                     | password        | role    |
    | oram        | Case Worker     | caseworker321@gmail.com  | caseworker  | employee |s

Scenario: Accessing the login page
  Given I am on the home page
  When I follow "Admin Sign In"
  Then I should be on the admin login page
  And I should not see "Sign up"
  
Scenario: Case Worker login info does not exist
 Given I am on the admin login page
 When I fill in "admin_email" with "invalid_email"
 When I fill in "admin_password" with "invalid_password"
 And I press "Log in"
 Then I should be on the admin login page
 Then I should see "Invalid Email or password."

Scenario: Valid Case Worker logging in
  Given I am on the admin login page
  Then I should see "Admin Log in"
  When I fill in "admin_email" with "caseworker321@gmail.com"
  When I fill in "admin_password" with "caseworker"
  And I press "Log in"
  Then I should not see "Invalid Email or password."
  And I should be on the home page

# Scenario: Case Worker should be able to view all case documents
#  Given I am on the Case Worker user profile page
#  When I press "All Cases"
#  Then I should see all case documents

# Scenario: Case Worker should be able to invite lawyers to view relevant cases
#  Given I am on the Case Worker user profile page
#  When I press "Invite Lawyers"
#  Then I should be on the invite lawyers page
