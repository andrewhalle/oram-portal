Given(/^I go back to the clients page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the following Case Workers exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^that I am assigned to the following clients:$/) do |clients|
  pending
end

When(/^I enter "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click "([^"]*)"$/) do |arg1|
  click_button(arg1)
end

Then(/^"([^"]*)" should be a Caseworker of "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^"([^"]*)" should be a Client of "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^"([^"]*)" is a Caseworker of "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end


Then(/^I remove "([^"]*)" as a Caseworker from "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I assign caseworker "([^"]*)" to client "([^"]*)"$/) do |arg1, arg2|
  steps %Q{
    Given I follow "Clients"
    And I view the profile of "#{arg2}"
    And I view "Caseworkers"
    And I select "#{arg1}" from the caseworker dropdown
    And I press "Assign Caseworker"
  } # Write code here that turns the phrase above into concrete actions
end

Given(/^I remove caseworker "([^"]*)" from client "([^"]*)"$/) do |arg1, arg2|
  steps %Q{
    Given I follow "Clients"
    And I view the profile of "#{arg2}"
    And I view "Caseworkers"
  } 
  client_id = User.get_id_by_name(arg2)
  #action = find("#remove_caseworker")[admin_delete_caseworker_path(:id => client_id, :caseworker => arg1)]
  find(:xpath, "//form[@action = '#{admin_delete_caseworker_path(:id => client_id, :caseworker => arg1)}']//button").click
  
end

Then(/^"([^"]*)" should not be a caseworker from client "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I remove client "([^"]*)" from caseworker "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^"([^"]*)" should not be a caseworker of client "([^"]*)"$/) do |arg1, arg2|
  steps %Q{
    Given I follow "Clients"
    And I view the profile of "#{arg2}"
    And I view "Caseworkers"
    Then I should not see "arg1"
  } # Write code here that turns the phrase above into concrete actions
end

Then(/^there should not be the caseworker dropdown$/) do
  expect(page).not_to have_selector(".assign-caseworker-select")
end
