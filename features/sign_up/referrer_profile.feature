Feature: Referrer Profile Form
  As a prospective referrer,
  In order to become a candidate for referrer vetting
  I should be able to fill out and submit a referrer form on my profile containing my information.

Background: Referrer in the database
  Given I am logged in as the following referrer:
  | first_name	| last_name	| email             	| password	| invitation_accepted_at | role        |
  | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test'                 | referrer    |

  Given I follow "Profile"
  And I follow "Edit"

Scenario: Submitting the form successfully
  Given I fill out the referrer profile form
  And I press "Submit"
  Then I should see "First Name:"

Scenario: Checking that conditional areas were filled out correctly and show up after being submitted
  Given I fill out the referrer profile form
  And I press "Submit"
  Then I should see "I was the founder of the organization."

# Scenario: Checking that you cannot submit an empty form
#  Given I press "Submit"
#  Then I should see "Please fill in the required fields"
