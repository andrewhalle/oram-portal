Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    Admin.create(admin)
  end
end

Given /I am an ORAM administrator/ do
	pending
end

Then /I should see all case documents/ do |case_documents_table|
  pending
end

Given /the following referrers exist/ do |t|
  pending
end
