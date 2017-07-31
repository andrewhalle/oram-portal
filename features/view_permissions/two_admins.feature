@javascript
Feature: there are two types of admin with different levels of access
    In order to differentiate between
    employees working particular cases
    and administrators overseeing all cases
    there should be two levels of admin
    
Background: there are admins in the database
  Given the following admins exist:
    | first_name | last_name | email              | password | role        |
    | central    | admin     | central@admin.com  | password | central     |
    | employee   | admin     | employee@admin.com | password | employee    |

Scenario: central admin can view all admins
    Given I am on the admin login page
    Then I should see "Admin Log in"
    When I fill in "admin_email" with "central@admin.com"
    When I fill in "admin_password" with "password"
    And I press "Log in"
    Then I should not see "Invalid Email or password."
    And I should be on the home page
    Then I should see "Admins"
    When I follow "Admins"
    Then I should see "central admin"
        And I should see "employee admin"
    When I view the first profile
    Then I should see "central admin"

Scenario: employee admin can't view all admins
    Given I am logged in with credentials "employee@admin.com" and "password"
    When I request the admins page
    Then I should see "You must be a central admin to do that!"
    