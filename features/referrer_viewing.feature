#Deprecated -- Alice on 07/21/2017
#
# Feature: Accept or Reject pending referrer application

#   As an ORAM administrator
#   In order to update the pending application status
#   I should be able to approve an application or notify the applicant of an incomplete application.

# Background: referrers in the database

# 	Given the following referrers exist:
# 	    | first_name	| last_name	| email             	| password	| invitation_accepted_at |
# 	 	  | Bryan			  | Adams     | bryan@adams.com		  | oram123	  | 'test' |
# 	 	  | Hannah		  | Montana   | hannah@montana.com	| oram123	  | 'test' |
# 	  	| Hillary		  | Clinton	  | hillary@clinton.com	| oram123	  | 'test' |
# 	  	| Adrian		  | Greenberg | adrian@greenberg.com| oram123	  | 'test' |
# 	  	| Donald		  | Trump		  | donald@trump.com		| oram123	  | 'test' |

# 	And I am logged in as the following admin:
# 	    | first_name  | last_name | email               | password   | role     |
# 	    | oram        | admin     | admin321@gmail.com  | oramadmin  | employee |

# Scenario: ORAM administrator visiting the prospective Referrer profile
# 	When I follow "Referrers"
# 	Then I should be on the referrers page

# Scenario: filter for incomplete applications
# 	Given I am on the referrers page
# 	When I select "Incomplete" from the status dropdown
# 	Then I should see "Hannah Montana"
# 	And I should see "Donald Trump"
# 	And I should not see "Hillary Clinton"

# Scenario: filter through all of the rejected applications
# 	Given I am on the referrers page
# 	When I select "Rejected" from the status dropdown
# 	Then I should see "Hillary Clinton"
# 	And I should not see "Donald Trump"

# Scenario: filter through all of the approved applications
# 	Given I am on the referrers page
# 	When I select "Approved" from the status dropdown
# 	Then I should see "Adrian Greenberg"

# #Scenario: send a notification to a referrer with an incomplete application
# #  When I go to the applications page
# #  And I go to the review page for "Hannah Montana"
# #  And I press "Notify of Application incompleteness"
# #  Then I should be on the applications page
# #  And I should not see "Hannah Montana"
