Feature: Admins can add notes to a client's profile that only they can see
  As an admin
  So that I can remember what I was doing
  I should be able to add notes to a clients profile
  
Background: client and admin in database
  Given the following clients exist:
    | first_name | last_name | email         | password | role   |
    | client     | user      | test@test.com | password | client |
  
  And the following admins exist:
    | first_name | last_name | email          | password | role   |
    | central    | admin     | admin@test.com | password | client |
  
  And I'm signed in as "central admin"
  And I'm on the profile page for "client user"

Scenario: admin adding a note to a client
  Then I should see "Notes"
  When I follow "Notes"
  Then I should see "Add note"
  When I click "Add note"
    And fill out the notes box with "This is a test note"
    And click "Add"
  Then I should be on the profile page for "client user"
    And I should see "This is a test note"
    
Scenario: deleting a note
  Given the following notes exist:
    | user_id | title | text                |
    | 1       | test  | this is a test note |
  When I follow "Notes"
  Then I should see "test"
  When I click "Delete"
  Then I should be on the profile page for "client user"
    And I should not see "test"
  
Scenario: editing a note
  Given the following notes exist:
    | user_id | title | text                |
    | 1       | test  | this is a test note |
  When I follow "Notes"
  Then I should see "test"
  When I expand "test"
  Then I should see "this is a test note"
  When I add " hello world" to the text box
    And I click "Save
  Then I should see "this is a test note hello world"