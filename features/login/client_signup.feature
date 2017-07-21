@javascript
Feature: client signing up should setup their profile 
  As a new client
  I should be able to setup my profile
  
Scenario: signup with profile attributes
  Given that I am on the signup page
  Then I should see Phone
  And I should see Skype
  And I should see Address