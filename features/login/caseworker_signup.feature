# MOVED TO INVITES INSTEAD

# @javascript
# Feature: Case Worker Login Portal
#   As a user with Case Worker access to the ORAM portal
#   In order to be able to sign up
#   I should be able to sign up

# Scenario: Accessing the sign up page
#   Given I am on the sign up page
#   When I follow "Case Worker Sign Up"
#   Then I should be on the Case Worker sign up page
#   And I should see "Log In"

# Scenario: Valid Case Worker signing in
#   Given I am on the Case Worker sign page
#   Then I should see "Case Worker Sign Up"
#   When I fill in "case_worker_email" with "case_worker_321@gmail.com"
#   When I fill in "admin_password" with "oramadmin"
#   And I press "Sign in"
#   Then I should not see "Your Email is not valid ot Sign up"
#   And I should be on on my landing page

# Scenario: Case Worker sign up info does not exist
# Given I am on the Case Worker sign up page
# When I fill in "admin_email" with "invalid_email"
# When I fill in "admin_password" with "invalid_password"
# And I press "Sign up"
# Then I should be on the admin sign up page
# Then I should see "IYour Email is not valid ot Sign up"
