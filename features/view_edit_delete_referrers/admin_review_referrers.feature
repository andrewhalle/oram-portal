@javascript
Feature: Vetting a Referrer
	As an ORAM administrator
	In order to vet referrers
	I should be able to view referrer profiles and approve or reject their profile request

Background: referrers in the database

	Given the following referrers exist:
	    | first_name	| last_name	| email             	| password	| invitation_accepted_at |
	 	  | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test' |
	 	  | Hannah		  | Montana   | hannah@montana.com	| oram123	  | 'test' |
	  	| Hillary		  | Clinton	  | hillary@clinton.com	| oram123	  | 'test' |
	  	| Adrian		  | Greenberg | adrian@greenberg.com| oram123	  | 'test' |
	  	| Donald		  | Trump		  | donald@trump.com		| oram123	  | 'test' |

	And I am logged in as the following admin:
	    | first_name  | last_name | email               | password   | role     |
	    | oram        | admin     | admin321@gmail.com  | oramadmin  | central |

Scenario: Approving the prospective Referrer profile
	Given I am on the referrers page
	When I view the profile of "Bryan Adams"
	And I press "Approve"
	Then I should be on the referrers page
	And I should see "Bryan Adams has been marked as approved"

Scenario: Rejecting the prospective Referrer profile
	Given I am on the referrers page
	When I view the profile of "Bryan Adams"
	And I press "Reject"
	Then I should be on the referrers page
	And I should see "Bryan Adams has been marked as rejected"

Scenario: Marking the prospective Referrer profile as incomplete
	Given I am on the referrers page
	When I view the profile of "Bryan Adams"
	And I press "Incomplete"
	Then I should be on the referrers page
	And I should see "Bryan Adams has been marked as incomplete"
