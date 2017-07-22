# this is for steps that all users -- including admins -- will need to use.

#taken from login_steps by Alice
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    User.create(user)
  end
end

#taken from login_steps by Alice
Given /the following clients exist/ do |clients_table|
  clients_table.hashes.each do |client|
    user = User.create(client)
    user.invitation_accepted_at = "2016-11-07 19:35:09"
    user.role = "client"
    json = "{\"First Name\":\"Nhi\",\"Middle Name(s)\":\"\",\"Surname(s)\":\"Quach\",\"Date of Birth\":\"\",\"City/Town\":\"\",\"Province\":\"\",\"Country\":\"\",\"Nationality\":\"Afghanistan\",\"Do you describe yourself as an active member of the LGBTIQ Community?\":\"No\",\"What is the name of your current employer?\":\"\",\"What position do you hold there?\":\"\",\"How did you first come in contact with ORAM?\":\"\",\"Please describe how you came to the ORAM referrer program\":\"\",\"Have you worked for or been associated with any LGBTIQ groups, organizations or community\\r\\nprojects that work with the LGBTIQ community?\":\"No\",\"Which organization? Please give a brief overview of your role\":\"\",\"Have you ever been trained to vet LGBTIQ individuals?\":\"No\",\"Which training? Please provide the training organization’s name, dates of the session and a brief overview of the training program\":\"\",\"Why do you want to be a referrer for ORAM? Please answer in less than 300 words\":\"\"}"
    user.forms.build({form_json: json, form_type: 3, status: "Incomplete", first_name: user.first_name, last_name: user.last_name})
    user.save
  end
end

#taken from what was originally oram_admin_steps.rb
Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    a = Admin.create
    puts admin
    a.first_name = admin["first_name"]
    a.last_name = admin["last_name"]
    a.email = admin["email"]
    a.password = admin["password"]
    a.role = admin["role"]
    a.save
  end
end

#taken from what was originally oram_admin_steps.rb
Given /the following referrers exist/ do |referrers_table|
    referrers_table.hashes.each do |referrer|
      user = User.create(referrer)
      user.invitation_accepted_at = "2016-11-07 19:35:09"
      user.role = "referrer"
      json = "{\"First Name\":\"Nhi\",\"Middle Name(s)\":\"\",\"Surname(s)\":\"Quach\",\"Date of Birth\":\"\",\"City/Town\":\"\",\"Province\":\"\",\"Country\":\"\",\"Nationality\":\"Afghanistan\",\"Do you describe yourself as an active member of the LGBTIQ Community?\":\"No\",\"What is the name of your current employer?\":\"\",\"What position do you hold there?\":\"\",\"How did you first come in contact with ORAM?\":\"\",\"Please describe how you came to the ORAM referrer program\":\"\",\"Have you worked for or been associated with any LGBTIQ groups, organizations or community\\r\\nprojects that work with the LGBTIQ community?\":\"No\",\"Which organization? Please give a brief overview of your role\":\"\",\"Have you ever been trained to vet LGBTIQ individuals?\":\"No\",\"Which training? Please provide the training organization’s name, dates of the session and a brief overview of the training program\":\"\",\"Why do you want to be a referrer for ORAM? Please answer in less than 300 words\":\"\"}"
      user.forms.build({form_json: json, form_type: 1, status: "Incomplete", first_name: user.first_name, last_name: user.last_name})
      user.save
    end
end


Given(/^the following relations exist:$/) do |relations_table|
  # table is a Cucumber::MultilineArgument::DataTable
 # Write code here that turns the phrase above into concrete actions
  relations_table.hashes.each do |relations|
    client_first_name, client_last_name = relations["client"].split(' ')
    client_id = User.where(first_name: client_first_name).where(last_name: client_last_name).first.id
    admin_first_name, admin_last_name = relations["caseworker"].split(' ')
    admin_id = Admin.where(first_name: admin_first_name).where(last_name: admin_last_name).first.id
    Ownership.create(:user_id => client_id, :admin_id => admin_id)
    
  end
end

Given(/^the following referrals exist:$/) do |referrals_table|
  referrals_table.hashes.each do |referral|
    referrer_first_name, referrer_last_name = referral["referrer"].split(' ')
    referrer_id = User.where(first_name: referrer_first_name).where(last_name: referrer_last_name).first.id
    client_first_name, client_last_name = referral["referral_name"].split(' ')
    referral = Form.create(:user_id => referrer_id, :form_type => 2, :first_name => client_first_name, :last_name => client_last_name)
    json = "{\"First Name\":\"Nhi\",\"Middle Name(s)\":\"\",\"Surname(s)\":\"Quach\",\"Date of Birth\":\"\",\"City/Town\":\"\",\"Province\":\"\",\"Country\":\"\",\"Nationality\":\"Afghanistan\",\"Do you describe yourself as an active member of the LGBTIQ Community?\":\"No\",\"What is the name of your current employer?\":\"\",\"What position do you hold there?\":\"\",\"How did you first come in contact with ORAM?\":\"\",\"Please describe how you came to the ORAM referrer program\":\"\",\"Have you worked for or been associated with any LGBTIQ groups, organizations or community\\r\\nprojects that work with the LGBTIQ community?\":\"No\",\"Which organization? Please give a brief overview of your role\":\"\",\"Have you ever been trained to vet LGBTIQ individuals?\":\"No\",\"Which training? Please provide the training organization’s name, dates of the session and a brief overview of the training program\":\"\",\"Why do you want to be a referrer for ORAM? Please answer in less than 300 words\":\"\"}"
    referral.form_json = json
    referral.save
  end
end

#originally taken from what was called client_document_steps.rb
When /I upload the file "(.*)"/ do |file_name|
  attach_file('case_document', File.absolute_path("./features/fileset/#{file_name}"))
end

# taken from what was called referrer_vetting_steps.rb
When /I view the profile of "(.*)\s(.*)"/ do |first_name, last_name|
    find(:xpath, "//tr[td[contains(.,'#{first_name}')]]/td/a", :text => 'View Profile').click
end

#taken from what was called referrer_vetting_steps.rb
Then /^(?:|I )should see a notification with  "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

#taken from what was called referrer_vetting_steps.rb
When (/I select "([^"]*)" from the status dropdown/) do |option|
    if option == "Status"
        find("option[value='Status']").click
    elsif option == "Incomplete"
        find("option[value='Incomplete']").click
    elsif option == "Complete"
      find("option[value='Complete']").click
    elsif option == "Approved"
      find("option[value='Approved']").click
    elsif option == "Rejected"
      find("option[value='Rejected']").click
    end
end

When(/^I select "([^"]*)" from the change phase dropdown$/) do |arg1|
  select(arg1, :from => "edit_client_changed_phase", visible: false) # Write code here that turns the phrase above into concrete actions
end

When(/^I select "([^"]*)" from the caseworker dropdown$/) do |arg1|
  select(arg1, :from => "edit_client_assign_caseworker", visible: false) # Write code here that turns the phrase above into concrete actions
end

