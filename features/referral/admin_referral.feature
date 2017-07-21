Feature: Central Admin checking the list of referrals
  As an ORAM administrator
  In order to approve or reject referred clients
  I want to be able to view the list of all current referrals with links to their forms

Background: Referrer creating referrals and loggin in as admin
  Given that I am logged in as the following referrer:
    | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
    | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test'                 | referrer    |

  And I follow "Refer Client"
  And I complete the client referral form
  And I press "Submit"

  Given that I am logged in as the following admin:
    | first_name  | last_name | email               | password   | role     |
    | oram        | admin     | admin321@gmail.com  | oramadmin  | central |

Scenario: Central Admin checking to see if the client appears in the table
  Given I follow "Referrals"
  Then I should see "Billy"

Scenario: Central Admin marking referrals as approved
  Given I follow "Referrals"
  Then I should see "Billy"
  When I view the profile of "Billy Joe"
  Then I should see "Billy Joe"
  When I press "Approve"
  Then I should be on the new user invitation page
  When I follow "Referrals"
  Then the status of "Billy Joe" should be "Approved"

Scenario: Central Admin marking referrals as rejected
  Given I follow "Referrals"
  Then I should see "Billy"
  When I view the profile of "Billy Joe"
  Then I should see "Billy Joe"
  When I press "Reject"
  Then the status of "Billy Joe" should be "Rejected"
  Given I follow "Clients"
  Then I should not see "Billy Joe"

Scenario: Central Admin marking referrals as Incomplete
  Given I follow "Referrals"
  Then I should see "Billy"
  When I view the profile of "Billy Joe"
  Then I should see "Billy Joe"
  When I press "Incomplete"
  Then the status of "Billy Joe" should be "Incomplete"
