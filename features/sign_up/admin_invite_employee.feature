@javascript
Feature: update the status of a pending application

  As a ORAM Administrator
  In order to create profiles for ORAM employees
  I should be able to send a portal link to allow employees to sign up and create their profile

Background: Logging in as an admin

  Given I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central  |

Scenario: Admins can invite users to make an account
  When I follow "Invitations"
  Then I should be on the new user invitation page

Scenario: Admins can invite users by email
  When I am on the new user invitation page
  And I fill in "Email" with "inviteduser@email.com"
  And I select "Referrer" from "user_role"
  And I press "Send an invitation"
  Then I should see "An invitation email has been sent to inviteduser@email.com"

#Scenario: View statuses of sent employee invitations
#  Given I am an ORAM administrator
#  When I am on the employee invitation status page
#  Then I should see "John Doe", "Jane Smith" and "Mike Do"

#Scenario: Sort employee invitations by name
#  Given I am an ORAM administrator
#  When I am on the employee invitation status page
#  Then I should see "John Doe", "Jane Smith" and "Mike Do"
#  When I press "name"
#  Then I should see "Mike Do" before "Jane Smith"
#  And I should see "Jane Smith" before "John Doe"

#Scenario: Sort employee invitations by status
#  Given I am an ORAM administrator
#  When I am on the employee invitation status page
#  Then I should see "John Doe", "Jane Smith" and "Mike Do"
#  When I press "status"
#  Then I should see "Jane Smith" before "Mike Do"
