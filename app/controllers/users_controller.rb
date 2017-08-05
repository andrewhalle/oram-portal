class UsersController < ApplicationController
	before_action :require_login

	def show
		@curr_admin = current_admin
		@user = User.find(params[:id])
		@caseworker_names = []
		@form_hash = {}
		@notes = @user.notes.reverse
		@updocs = Updoc.where(user_id: @user.id).all
		if !@user.ownerships.nil?
			@user.ownerships.each do |ownership|
				@caseworker_names.append(Admin.find_by_id(ownership.admin_id).full_name)
			end
		end
		if !@user.events.last.nil?
			@last_event_message = @user.events.last.message
		end
		if @user.role == "referrer"
			if !@user.forms.empty? && !@user.forms.where(form_type: 1).empty?
				referrer_forms = @user.forms.where(form_type: 1)
				@form_id = referrer_forms.first.id
				@form_hash = JSON.parse(referrer_forms.first.form_json)
			end
			render :referrer_profile
		elsif @user.role == "client"
			if !@user.forms.empty? && !@user.forms.where(form_type: 3).empty?
				client_form = @user.forms.where(form_type: 3)
				@form_id = client_form.first.id
				@form_hash = JSON.parse(client_form.first.form_json)
			end
			@events = Event.where(:user_id => @user.id).all.reverse
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

	def client_documents
		@client = User.find_by_id(params[:id])
		@document = @client.case_document
		render :client_documents
	end
	
    def client_settings_edit
		@user = current_user
		render :client_edit_profile
    end
    
	def client_setting
		@client = current_user
		render :client_setting
	end
    
	def client_edit_save
		User.update(params[:id], 
		{:first_name => params["user"]["first_name"], 
		:last_name => params["user"]["last_name"], 
		:email => params["user"]["email"], 
		:phone => params["user"]["phone"], 
		:address => params["user"]["address"],
		:skype => params["user"]["skype"]})
		redirect_to :client_setting
	end

	def upload_document
		@client = User.find_by_id(params[:id])
		user_setting = params[:user_setting]
		@client.update_attribute(:user_setting, user_setting)
		@client.save!
		redirect_to setting_path(@client)
	end
	
	def referrer_setting
		render :client_setting
	end 
	
	def referrer_destroy
		redirect_to destroy_user_session_path
		@client = User.find_by_id(params[:id])
		@client.destroy
	end 
	
	def client_destroy
		redirect_to destroy_user_session_path
		@client = User.find_by_id(params[:id])
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
		redirect_to :client_setting
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

end
