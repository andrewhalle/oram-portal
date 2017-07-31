@javascript
Feature: Admins can add notes to a client's profile that only they can see
  As an admin
  So that I can remember what I was doing
  I should be able to add notes to a clients profile
  
Background: client and admin in database
  Given the following clients exist:
    | first_name | last_name | email         | password | role   |
    | client     | user      | test@test.com | password | client |
  
  And I am logged in as the following admin
    | first_name | last_name | email          | password | role    |
    | central    | admin     | admin@test.com | password | central |

  And I'm on the profile page for "client user"

Scenario: admin adding a note to a client
  Then I should see "Notes"
  When I follow "Notes"
  Then I should see "Add note"
  When I fill out the title with "This is a test note"
  And I click "Add note"
  Then I should see "This is a test note"
    
Scenario: deleting a note
  Given the following notes exist:
    | user_id | title            | text                |
    | 1       | test note title  | this is a test note |
  And I'm on the profile page for "client user"
  When I follow "Notes"
  Then I should see "test note title"
  When I expand "test note title"
  Then I should see "Delete note"
  When I follow "Delete note"
  Then I should not see "test note title"
  
Scenario: editing a note
  Given the following notes exist:
    | user_id | title            | text                |
    | 1       | test note title  | this is a test note |
  And I'm on the profile page for "client user"
  When I follow "Notes"
  Then I should see "test note title"
  When I expand "test note title"
    And I fill out the note with "this is a test note hello world"
  When I press "Save"
  Then I should see "test note title"