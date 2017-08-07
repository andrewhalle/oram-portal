class UsersController < ApplicationController
	
	include UsersHelper
	
	before_action :require_login

	def show
		@curr_admin = current_admin
		@user = User.find(params[:id])
		@caseworker_names = []
		@form_hash = {}
		@notes = @user.notes.reverse
		@updocs = Updoc.where(user_id: @user.id).all
		@events = Event.where(:user_id => @user.id).all.reverse
		@calendar_url = get_calendar_url(@user.calendar_id)
		if !@user.ownerships.nil?
			@user.ownerships.each do |ownership|
				@caseworker_names.append(Admin.find_by_id(ownership.admin_id).full_name)
			end
		end
		if !@user.events.last.nil?
			@last_event_message = @user.events.last.message
		end
		if @user.role == "referrer"
			type = 1
			@form_hash = get_form(@user, type)
			render :referrer_profile
		elsif @user.role == "client"
			type = 3
			@form_hash = get_form(@user, type)
			render :client_profile
		end
	end

	def edit_referrer_profile
		@referrer = User.find_by_id(params[:id])
		@gender_identity_options = @referrer.gender_identity_options
		@referrer_contact_options = @referrer.referrer_contact_options
		@referrer_LGBTIQ_social_media = @referrer.referrer_LGBTI_social_media
		@referrer_LBGTIQ = @referrer.LGBTIQ_options
		@current_form = @referrer.getFormHash(@referrer.forms.where(form_type: 1).first) || {}
		render :referrer_edit
	end

	def get_country(country_code)
		if !country_code.nil? && !country_code.empty?
			country = ISO3166::Country[country_code]
			return country.name
		end	
	end
	
	def update_profile(form_type, redirect_path)
		@user = User.find_by_id(params[:id])
		country_code = params["form_response"]["Country Of Birth"]
		params["form_response"]["Country Of Birth"] = get_country(country_code)
		if !country_code.nil? && !country_code.empty?
			country = ISO3166::Country[country_code]
			params["form_response"]["Country Of Birth"] = country.name
			@user.country = country.name
		end
		@user.languages = params["form_response"]["Languages Spoken"]
		@user.save
		gen_forms(@user)
		@form_response = params["form_response"].to_json
		@form_type = form_type
		@user_form = @user.forms.where(form_type: @form_type).first
		if !@user_form
			@user_form = @user.forms.build({form_json: @form_response, form_type: @form_type, status: "Incomplete", first_name: @user.first_name, last_name: @user.last_name})
		else
			@user_form.update_attribute(:form_json, @form_response)
		end
		if @user_form.save
			flash[:notice] = "Form successfully saved"
			rd_path = eval(redirect_path)
			redirect_to rd_path and return
		end
		flash[:error] = "Form failed to save"
		redirect_to root_path
	end
	
	def update_referrer_profile
		update_profile(1, "referrer_path(@user)")
	end
	
	def update_client_profile
		update_profile(3, "client_path(@user)")
	end

	def edit_client_profile
		@client = User.find_by_id(params[:id])
		@client_languages = @client.client_languages
		@turkey_legal_status = User.remove_unsure(@client.turkey_legal_status)
		@yes_no = User.remove_unsure(@client.yes_no_unsure)
		@yes_no_unsure = @client.yes_no_unsure
		@living_situation = User.remove_unsure(@client.living_situation)
		@refugee_claim = @client.refugee_claim
		@sex = @client.sex
		@sexual_orientiation = @client.sexual_orientation
		@client_gender_identity = @client.client_gender_identity
		@client_partner = User.remove_unsure(@client.client_partner)
		@client_openness = User.they_to_you(User.remove_unsure(@client.client_openness))
		@client_dangers = User.they_to_you(@client.client_dangers)
		@client_incident = @client.client_incident
		@mental_illness = @client.mental_illness
		@arrest = @client.arrest
		@documentary_evidence = @client.documentary_evidence
		@no_questionnaire_relationships = @client.no_questionnaire_relationships
		@yes_questionnaire_relationships = @client.yes_questionnaire_relationships
		@professional_capacity = @client.professional_capacity
		@relationship_level = @client.relationship_level
		@turkey_legal_status = @client.turkey_legal_status
		@living_situation = @client.living_situation
		@refugee_claim = @client.refugee_claim
		@current_form = @client.getFormHash(@client.forms.where(form_type: 3).first) || {}
		render :client_edit
	end

	def referrals
		@curr_admin = current_admin
		referrer = User.find_by_id(current_user.id)
		@referrals = referrer.forms.where(:form_type => 2)
		render "referrals"
	end

	def refer_client
		@referrer = User.find_by_id(params[:id])
		@gender_identity_options = @referrer.gender_identity_options
		@referrer_contact_options = @referrer.referrer_contact_options
		@referrer_LGBTIQ_social_media = @referrer.referrer_LGBTI_social_media
		@referrer_LBGTIQ = @referrer.LGBTIQ_options
		@client_languages = @referrer.client_languages
		@sex = @referrer.sex
		@yes_no_unsure = @referrer.yes_no_unsure
		@sexual_orientation = @referrer.sexual_orientation
		@client_gender_identity = @referrer.client_gender_identity
		@client_partner = @referrer.client_partner
		@client_openness = @referrer.client_openness
		@client_dangers = @referrer.client_dangers
		@client_incident = @referrer.client_incident
		@mental_illness = @referrer.mental_illness
		@arrest = @referrer.arrest
		@documentary_evidence = @referrer.documentary_evidence
		@no_questionnaire_relationships = @referrer.no_questionnaire_relationships
		@yes_questionnaire_relationships = @referrer.yes_questionnaire_relationships
		@professional_capacity = @referrer.professional_capacity
		@relationship_level = @referrer.relationship_level
		@turkey_legal_status = @referrer.turkey_legal_status
		@living_situation = @referrer.living_situation
		@refugee_claim = @referrer.refugee_claim
		render :refer_client
	end

	def create_referral
		country_code = params["form_response"]["Country Of Birth"]
		params["form_response"]["Country Of Birth"] = get_country(country_code)
		client_first_name = params["form_response"]["First Name"]
		client_last_name = params["form_response"]["Surname(s)"]
		@form_response = params["form_response"].to_json
		@form_type = 2
		@user = User.find_by_id(params[:id])
		@user_form = @user.forms.build({first_name: client_first_name, last_name: client_last_name, status: "Incomplete", form_json: @form_response, form_type: @form_type})
		if @user_form.save
			flash[:notice] = "Form successfully saved"
			redirect_to referrals_path(@user) and return
		end
		flash[:error] = "Form failed to save"
		redirect_to root_path
	end

	# def client_documents
	# 	@client = User.find_by_id(params[:id])
	# 	@document = @client.case_document
	# 	render :client_documents
	# end
	
    def user_settings_edit
		@user = current_user
		render :user_edit_profile
    end
    
	def user_setting
		@client = current_user
		render :user_setting
	end
    
	def user_edit_save
		User.update(params[:id], 
		{:first_name => params["user"]["first_name"], 
		:last_name => params["user"]["last_name"], 
		:email => params["user"]["email"], 
		:phone => params["user"]["phone"], 
		:address => params["user"]["address"],
		:skype => params["user"]["skype"]})
		redirect_to :user_setting
	end

	# def upload_document
	# 	@client = User.find_by_id(params[:id])
	# 	user_setting = params[:user_setting]
	# 	@client.update_attribute(:user_setting, user_setting)
	# 	@client.save!
	# 	redirect_to setting_path(@client)
	# end
	
	# def referrer_setting
	# 	render :client_setting
	# end 
	
	# def referrer_destroy
	# 	redirect_to destroy_user_session_path
	# 	@client = User.find_by_id(params[:id])
	# 	@client.destroy
	# end 
	
	def user_destroy
		@client = User.find_by_id(params[:id])
		if user_signed_in?
			redirect_to destroy_user_session_path
		elsif admin_signed_in?
			if @client.role == "client"
				redirect_to clients_path
			elsif @client.role == "referrer"
				redirect_to referrers_path
			end
		end
		@client.destroy
	end
	
	def case_status
		@status = {phase_one: "Applicant vetting"}
	end 
	
	def user_pass_change
		@curr_user = current_user
		@user = User.find_by_id(params[:id])
		render :user_pass_change
	end
	
	def user_pass_save
		@curr_user = current_user
		curr = params["user"]["encrypted_password"]
		if (@curr_user.valid_password?(curr))
			pass1 = params["user"]["pass_reset1"]
			pass2 = params["user"]["pass_reset2"]
			if (pass1 == pass2)
				if (pass1.length > 5)
					new_pass = User.create(:password => pass1).encrypted_password
					@curr_user.encrypted_password = new_pass
					@curr_user.save
				else 
					flash[:alert] = "Your new password must be longer than 5 characters."
				end
			else
				flash[:alert] = "Your new password and confirmation password do not match. Please try again."
			end
		else
			flash[:alert] = "Your old password is incorrect. Please try again."
		end
		redirect_to :user_setting
	end
	

	private
		def require_login
			if current_user
				if current_user.id != params[:id].to_i
					flash[:error] = "You are not currently logged in to have access to this section"
	      	redirect_to root_path and return
				end
				return
			end
			if !current_admin
				flash[:error] = "You are not currently logged in to have access to this section"
	      redirect_to root_path
			end
		end
		
		def gen_forms(user)
			if !(Dir.exists? Rails.root.join("public", "ag_forms", "clients", user.id.to_s))
				pdftk = PdfForms.new('/usr/bin/pdftk')
				Dir.mkdir Rails.root.join("public", "ag_forms", "clients", user.id.to_s)
				if user.country == "Syrian Arab Republic"
					#fill syrian arabic forms
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Arabic_Syrian", "1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").to_s, 
					{:client_name1 => user.full_name, :resident_country1 => user.country, :client_name2 => user.full_name, 
					:resident_country2 => user.country}
					doc = Updoc.new(:name => "1)ORAM_Confidentiality_Waiver[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Arabic_Syrian", "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					{:NameOfApplicantEng => user.full_name, :NameOfApplicantAra => user.full_name}
					doc = Updoc.new(:name => "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").open)
					user.updocs << doc
					#need :DateOfBirthEng => user. 
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Arabic_Syrian", "3)ORAM_Client_in_take_Form[Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "3)ORAM_Client_in_take_Form[Arabic].pdf").to_s
					doc = Updoc.new(:name => "3)ORAM_Client_in_take_Form[Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"3)ORAM_Client_in_take_Form[Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Arabic_Syrian", "4)ORAM_Engagement_Agreement_Syrian[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"4)ORAM_Engagement_Agreement_Syrian[English_Arabic].pdf").to_s, {:creation_date1 => (Date.today).to_s, 
					:client_name1 => user.full_name, :creation_date2 => (Date.today).to_s, :client_name2 => user.full_name, 
					:client_name3 => user.full_name, :client_name4 => user.full_name, :email1 => user.email, 
					:email2 => user.email, :phone_number1 => user.phone, :phone_number2 => user.phone}
					doc = Updoc.new(:name => "4)ORAM_Engagement_Agreement_Syrian[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"4)ORAM_Engagement_Agreement_Syrian[English_Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Arabic_Syrian", "5)ORAM_Client_Claim_Guide_[Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "5)ORAM_Client_Claim_Guide_[Arabic].pdf").to_s
					doc = Updoc.new(:name => "5)ORAM_Client_Claim_Guide_[Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"5)ORAM_Client_Claim_Guide_[Arabic].pdf").open)
					user.updocs << doc
					
				elsif user.languages.include? "Arabic"
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Arabic_Non_Syrian", "1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").to_s, {:client_name1 => user.full_name, 
					:resident_country1 => user.country, :client_name2 => user.full_name, :resident_country2 => user.country}
					doc = Updoc.new(:name => "1)ORAM_Confidentiality_Waiver[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"1)ORAM_Confidentiality_Waiver[English_Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Arabic_Non_Syrian", "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					{:NameOfApplicantEng => user.full_name, :NameOfApplicantAra => user.full_name}
					doc = Updoc.new(:name => "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").open)
					user.updocs << doc
					#need :DateOfBirthEng => user. 
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Arabic_Non_Syrian", "3)ORAM_Client_in_take_Form[Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "3)ORAM_Client_in_take_Form[Arabic].pdf").to_s
					doc = Updoc.new(:name => "3)ORAM_Client_in_take_Form[Arabic].pdf", :attachment => 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "3)ORAM_Client_in_take_Form[Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Arabic_Non_Syrian", "4)ORAM_Engagement_Agreement[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"4)ORAM_Engagement_Agreement[English_Arabic].pdf").to_s, {:creation_date1 => (Date.today).to_s, 
					:client_name1 => user.full_name, :creation_date2 => (Date.today).to_s, :client_name2 => user.full_name, 
					:client_name3 => user.full_name, :client_name4 => user.full_name, :email1 => user.email, 
					:email2 => user.email, :phone_number1 => user.phone, :phone_number2 => user.phone}
					doc = Updoc.new(:name => "4)ORAM_Engagement_Agreement[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"4)ORAM_Engagement_Agreement[English_Arabic].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Arabic_Non_Syrian", "5)ORAM_Client_Claim_Guide[Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "5)ORAM_Client_Claim_Guide[Arabic].pdf").to_s
					doc = Updoc.new(:name => "5)ORAM_Client_Claim_Guide[Arabic].pdf", :attachment => 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "5)ORAM_Client_Claim_Guide[Arabic].pdf").open)
					user.updocs << doc
					
				elsif user.languages.include? "Persian/Farsi"
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Farsi", "1)ORAM_Confidentiality_Waiver[English].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"1)ORAM_Confidentiality_Waiver[English].pdf").to_s, {:client_name1 => user.full_name, 
					:resident_country1 => user.country, :client_name2 => user.full_name, :resident_country2 => user.country}
					doc = Updoc.new(:name => "1)ORAM_Confidentiality_Waiver[English].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"1)ORAM_Confidentiality_Waiver[English].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", "Farsi", 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").to_s, 
					{:NameOfApplicantEng => user.full_name, :NameOfApplicantAra => user.full_name}
					doc = Updoc.new(:name => "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf").open)
					user.updocs << doc
					#need :DateOfBirthEng => user. 
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", 
					"Farsi", "3)Client_Intake_Form_Bilinugual[English_Persian].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"3)Client_Intake_Form_Bilinugual[English_Persian].pdf").to_s
					doc = Updoc.new(:name => "3)Client_Intake_Form_Bilinugual[English_Persian].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s,
					"3)Client_Intake_Form_Bilinugual[English_Persian].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", "templates", "Farsi", 
					"4)ORAM_Engagement_Agreement[English].pdf").to_s, Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"4)ORAM_Engagement_Agreement[English].pdf").to_s, {:creation_date1 => (Date.today).to_s, 
					:client_name1 => user.full_name, :creation_date2 => (Date.today).to_s, :client_name2 => user.full_name, 
					:client_name3 => user.full_name, :client_name4 => user.full_name, :email1 => user.email, 
					:email2 => user.email, :phone_number1 => user.phone, :phone_number2 => user.phone}
					doc = Updoc.new(:name => "4)ORAM_Engagement_Agreement[English].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "4)ORAM_Engagement_Agreement[English].pdf").open)
					user.updocs << doc
					
					generated_document = pdftk.fill_form Rails.root.join("public", "ag_forms", 
					"templates", "Farsi", "5)ORAM_Client_Claim_Guide_[Turkey].pdf").to_s, 
					Rails.root.join("public", "ag_forms", "clients", user.id.to_s, "5)ORAM_Client_Claim_Guide_[Turkey].pdf").to_s
					doc = Updoc.new(:name => "5)ORAM_Client_Claim_Guide_[Turkey].pdf", 
					:attachment => Rails.root.join("public", "ag_forms", "clients", user.id.to_s, 
					"5)ORAM_Client_Claim_Guide_[Turkey].pdf").open)
					user.updocs << doc
				end
			end
		end
end
