Given(/^I'm signed in as "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I'm on the profile page for "([^"]*)"$/) do |arg1|
  names = arg1.split()
  fname = names[0]
  lname = names[1]
  client = User.where(:first_name => fname, :last_name => lname).first
  url = client_path(client.id)
  visit url
end

When(/^I fill out the title with "([^"]*)"$/) do |arg1|
  fill_in "Title for new note", :with => arg1
end

Given(/^the following notes exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |note|
    Note.create(note)
  end
end

When(/^I expand "([^"]*)"$/) do |arg1|
  find("h4", :text => arg1).click()
end

When(/^I click "Save$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^SCREENSHOT$/) do
  page.save_screenshot "screenshot.png"
end

When(/^I wait (\d+) second$/) do |arg1|
  sleep(arg1.to_i)
end

When(/^I fill out the note with "([^"]*)"$/) do |arg1|
  fill_in "note_text_1", :with => arg1
end