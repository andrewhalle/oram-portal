@javascript
Feature: Login Portal
  As a user with granted access to the ORAM portal
  In order to view relevant case documents
  I should be able to login under my user profile

Background: Users in the database

  Given the following users exist:
    | first_name  | last_name    | email               | password | role     |
    | oram        | account      | oram123@gmail.com   | oram123  | client   |
    | referrer    | account      | oram321@gmail.com   | password | referrer |

Scenario: Accessing the login page
  Given I am on the home page
  When I follow "Sign in"
  Then I should be on the login page

Scenario: Valid User Logging In
  Given I am on the login page
  When I fill in "user_email" with "oram123@gmail.com"
  When I fill in "user_password" with "oram123"
  When I press "Log in"
  #Then I should be on the home page - redirecting to questionnaire now if it doesn't exist
  #And I should see "Signed in successfully."
  #Then I should see "Latest"
  Then I should see "Please fill out your questionnaire first."

Scenario: User login info does not exist
 Given I am on the login page
 When I fill in "user_email" with "badlogin@gmail.com"
 When I fill in "user_password" with "badpw"
 When I press "Log in"
 Then I should be on the login page
 And I should see "Invalid Email or password."
 
Scenario: when forms exist, go to status feed for client
  Given the following forms exist:
    | user_id | form_type | status     |
    | 1       | 3         | Incomplete |
  And I am on the login page
  When I fill in "user_email" with "oram123@gmail.com"
  When I fill in "user_password" with "oram123"
  When I press "Log in"
  Then I should be on the home page
  And I should see "Signed in successfully."
  
Scenario: when forms exist, go to status feed for referrer
  Given the following forms exist:
    | user_id | form_type | status     |
    | 2       | 1         | Incomplete |
  And I am on the login page
  When I fill in "user_email" with "oram321@gmail.com"
  When I fill in "user_password" with "password"
  When I press "Log in"
  Then I should be on the home page
  And I should see "Signed in successfully."
  
