# this is a file for all the steps related to logging in

# taken from what was previously referrer_vetting_steps.rb
And /I am logged in as the following admin/ do |admin_table|
    @admin = nil

    admin_table.hashes.each do |admin|
        @admin = Admin.create(admin)
    end
    visit new_admin_session_path
    fill_in("admin_email", :with => @admin.email)
    fill_in("admin_password", :with => @admin.password)
    click_button("Log in")
end

Given /I am logged in as the following client/ do |clients_table|
  @client = nil

  clients_table.hashes.each do |client|
    @client = User.create(client)
    @client.role = client["role"]
    @client.save
  end

  visit new_user_session_path
  fill_in("user_email", :with => @client.email)
  fill_in("user_password", :with => @client.password)
  click_button("Log in")
end

#taken from what was called applicant_profile_steps.rb
Given /I am logged in as the referrer "(.*)\s(.*)"/ do |first_name, last_name|
  @user = User.find_by_first_name(first_name)
  visit "users/sign_in"
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Log in"
end

#taken from what was called referrer_profile_steps.rb
Given /I am logged in as the following referrer/ do |referrer_table|
    @referrer = nil

    referrer_table.hashes.each do |referrer|
      @referrer = User.create(referrer)
    end

    visit new_user_session_path
    fill_in("user_email", :with => @referrer.email)
    fill_in("user_password", :with => @referrer.password)
    click_button("Log in")
end

#taken from what was previously called referrer_signup_steps.rb
Then /I should not have admin access/ do
    pending
end

Given(/I change my password from "([^"]*)" to "([^"]*)"$/) do |arg1, arg2|
  steps %Q{ 
    Given I follow "Settings"
    And I press "Change Password"
    And I fill in "admin_encrypted_password" with "#{arg1}"
    And I fill in "admin_pass_reset1" with "#{arg2}"
    And I fill in "admin_pass_reset2" with "#{arg2}"
    And I press "Update Admin"
    Then I should see "ORAM Website"
  }
end

When(/^I login as admin with email "([^"]*)" and password "([^"]*)"$/) do |arg1, arg2|
  steps %Q{
    When I go to the admin login page
    When I fill in "admin_email" with "donald@trump.com"
    And I fill in "admin_password" with "oram123"
    And I press "Log in"
  }
end