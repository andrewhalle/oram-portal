Given(/^I am logged in with credentials "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
    visit new_admin_session_path
    fill_in("admin_email", :with => arg1)
    fill_in("admin_password", :with => arg2)
    save_page
    click_button("Log in")
end

When(/^I request the admins page$/) do
  visit admins_path
end

When(/^I view the first profile$/) do
  first(:link, "View Profile").click
end

Then(/^I should see the alert "([^"]*)"$/) do |arg1|
  expect(page).to have_content("#{arg1}")
end