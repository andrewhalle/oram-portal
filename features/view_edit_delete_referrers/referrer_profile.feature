Feature: Referrer Profile Editing
  As a referrer with access to my referrer profile
  In order to fix information on my profile
  I should be able to edit my profile

Scenario: Only referrer should see the edit link
    Given I am logged in as the following referrer:
      | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
      | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test'                 | referrer    |
    Then I should see "About"
    And I follow "Profile"
    Then I should see "Edit"

Scenario: Admin should not be able to edit the referrer profile
    Given I am logged in as the following admin:
      | first_name  | last_name | email               | password   | role     |
      | oram2       | admin     | admin321@gmail.com  | oramadmin  | employee |

    And the following referrers exist:
      | first_name	| last_name	| email             	| password	| invitation_accepted_at |
      | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test' |

    And I follow "Referrers"
    Then I should see "Bryan"
    And I view the profile of "Bryan Adams"
    Then I should not see "Edit"
    
Scenario: Client trying to change their password
  Given PENDING
  Given I follow "Settings"
  Then I should see "Change Password"
  When I follow "Change Password"