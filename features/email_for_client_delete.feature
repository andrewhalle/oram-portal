Feature: clients should get an email confirming that they want to delete their account
  So that clients don't accidentally delete their account
  Their account should not be deleted
  Until they confirm by clicking the link in their email
  
Background: client exists in database
  Given the following clients exist:
    | first_name | last_name | email         | password | role   |
    | test       | user      | test@blah.com | password | client |

Scenario: deleting client
  Given PENDING
  Given I am on the settings page
  When I delete my account
  Then an email should be sent
    And "test user" should still be in the database