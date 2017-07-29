# This will contain steps for things that the client should be able to view in their own profile, things
# that client changes, and so on. This will be a slow refactoring of the other numerous client_*_steps.
# - Alice

Then /the status of "(.*)\s(.*)" should be "(.*)"/ do |first_name, last_name, status|
  # find(:xpath, "//tr[td[contains(.,'#{first_name}')]]/td/a", :text => '#{status}')
  find('tr', text: first_name).should have_content(status)
end

Then /the phase of "(.*)\s(.*)" should be "(.*)"/ do |first_name, last_name, phase|
  find('tr', text: first_name).should have_content(phase)
end

Then(/^my name should be "([^"]*)"$/) do |arg1|
    if page.respond_to? :should
        page.should have_content(arg1)
    else
        assert page.has_content?(arg1)
  end
end

Then(/^my email should be "([^"]*)"$/) do |arg1|
  if page.respond_to? :should
        page.should have_content(arg1)
    else
        assert page.has_content?(arg1)
  end
end

Then(/^my phase should be "([^"]*)"$/) do |arg1|
  if page.respond_to? :should
        page.should have_content(arg1)
    else
        assert page.has_content?(arg1)
  end
end


#taken from the previous client_settings_steps.rb, now gone
When /^(?:|I )confirm/ do
    page.evaluate_script('window.confirm = function() { return true;}')
    page.click_button('OK')
end 

#taken from what was originally called client_settings.rb
#This seems to be related to editing or deleting a profile.
When /^(?:|I )have pressed "([^"]*)"$/ do |button|
  begin
    main, popup = page.driver.browser.window_handles
    within_window(popup) do
      click_button("Ok")
    end
  rescue
  end
end

#taken from what was originally called client_settings.rb
When(/^I say I'm outside my country of origin$/) do
  find('.client-outside-country').find(:xpath, 'option[1]').select_option
end
