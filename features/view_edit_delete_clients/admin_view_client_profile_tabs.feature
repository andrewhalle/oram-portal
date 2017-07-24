@javascript
Feature: Client Profile Tabs
  To ensure that any user accessing the client profile page has correct permissions and information
  I should see tabs with all events, caseworkers, and documents related to the client

Background: Logging in as a client with an account

  Given the following clients exist:
    | first_name  | last_name   | email                 | password     	  | role		| phase   |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client		| Phase 1 |

  And I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central  |
    
Scenario: Admin viewing status feed
  Given I follow "Clients"
  And I view the profile of "Bryan Adams"
    Then I should see "Client Activity Feed"
    And I should not see "Assign Caseworkers"
    And I should not see "All Documents"
    

    
Scenario: Client trying to delete their profile
  Given PENDING
  Given I follow "Settings"
  When I press "Delete Profile"
  When I confirm
  Then I should be on the home page

Scenario: Client trying to view and edit their profile
  Given Pending
  Given I follow "Profile"
  Then I should see "Edit"
  When I follow "Edit"
  Then I should see "First Name:"
  When I say I'm outside my country of origin
    And I press "Submit"
  #Then I should see "Edit"
  
Scenario: Client trying to change their password
  Given PENDING
  Given I follow "Settings"
  Then I should see "Change Password"
  When I follow "Change Password"
  
