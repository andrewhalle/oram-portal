Feature: Clients are redirected to their questionnaire immediately after signing up
  So that clients can easily find their questionnaire
  Accepting an invitation to the platform
  Should direct the client to the questionnaire after they fill in their profile details
  
Background: client has been invited
  Given the following client has been invited:
    | email         | auth_token |
    | test@blah.com | test_token |

Scenario: accepting invitation
  Given I visit the accept invitation page with token "test_token"
  When I fill out my profile data with:
    | first_name | last_name | password |
    | test       | user      | password |
    And I click "Submit"
  Then I should be on the questionnaire page