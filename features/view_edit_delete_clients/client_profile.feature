@javascript
Feature: Client Profile
  As an approved client
  In order to provide the necessary information to be considered for refugee status
  I want to be able view and edit my profile

Background: Logging in as a client with an account

  Given I am logged in as the following client:
    | first_name  | last_name   | email                 | password     	  | role					| phase   |
    | Bryan       | Adams     	| bryan@adams.com       | oram123         | client			  | Phase 1 |

Scenario: Client trying to view their profile
  Given I follow "Profile"
  Then my name should be "Bryan Adams"
    And my email should be "bryan@adams.com"
    And my phase should be "Phase 1"
    
    
Scenario: Client trying to edit their profile
  Given I follow "Settings"
  When I press "Edit Profile"
  Then I should see "First name:"
  When I fill in "user[first_name]" with "Andrew"
    And I press "Update User"
    And I go to the home page
    And I follow "Profile"
  Then I should see "Andrew Adams"
    
Scenario: Client trying to delete their profile
  Given PENDING
  Given I follow "Settings"
  When I press "Delete Profile"
  When I confirm
  Then I should be on the home page

Scenario: Client trying to view and edit their profile
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
  
