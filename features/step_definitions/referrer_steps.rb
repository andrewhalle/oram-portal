#this is a steps file for all the steps related to being logged in as a referrer.
# - Alice

When /I fill out the referrer profile form/ do
  fill_in "form_response_First_Name" , :with => "Bryan"
  fill_in "form_response_Middle_Name_s_" , :with => "John"
  fill_in "form_response_Surname_s_" , :with => "Adams"
  fill_in "form_response_Date_of_Birth" , :with => "01/01/2001"
  fill_in "form_response_City_Town" , :with => "Tehran"
  fill_in "form_response_Province" , :with => "Province"
  fill_in "form_response_Country" , :with => "Persia"
  find('#form_response_Nationality').find(:xpath, 'option[2]').select_option
  find(:css, "#form_response_Gender_Identity_[value='Transgender']").set(true)
  find('#form_response_Do_you_describe_yourself_as_an_active_member_of_the_LGBTIQ_Community_').find(:xpath, 'option[1]').select_option
  fill_in "form_response_What_is_the_name_of_your_current_employer_" , :with => "Company A"
  fill_in "form_response_What_position_do_you_hold_there_" , :with => "Job A"
  fill_in "form_response_How_did_you_first_come_in_contact_with_ORAM_" , :with => "I was recommended by a friend to apply to be a referrer"
  fill_in "form_response_Please_describe_how_you_came_to_the_ORAM_referrer_program" , :with => "I was recommended by a friend to apply to be a referrer"
  find('#form_response_Have_you_worked_for_or_been_associated_with_any_LGBTIQ_groups__organizations_or_community_projects_that_work_with_the_LGBTIQ_community_').find(:xpath, 'option[2]').select_option
  fill_in "form_response_Which_organization__Please_give_a_brief_overview_of_your_role" , :with => "I was the founder of the organization."
  find('#form_response_Have_you_ever_been_trained_to_vet_LGBTIQ_individuals_').find(:xpath, 'option[1]').select_option
  fill_in "form_response_Which_training__Please_provide_the_training_organization_s_name__dates_of_the_session_and_a_brief_overview_of_the_training_program" , :with => "Organization A from 1/1/1995 to 6/1/1995, basic training."
  find(:css, "#form_response_Have_you_ever_used_any_LGBTI-specific_social_media_platforms__[value='Gaydar']").set(true)
  find(:css, "#form_response_Have_you_ever_used_any_LGBTI-specific_social_media_platforms__[value='Scruff']").set(true)
  fill_in "form_response_Why_do_you_want_to_be_a_referrer_for_ORAM__Please_answer_in_less_than_300_words", :with => "I want to help save refugees."
end

When(/^I view "Referrer Form"$/) do
  find('#form', :text => "Referrer Form").click
end
  