class AdminsController < ApplicationController

	before_filter :authenticate_admin!

	def show_referrers
		@curr_admin = current_admin
		#@referrers = User.where(role: User.roles[:referrer]).where.not(invitation_accepted_at: nil)
		if @curr_admin.role == "central"
			@referrers = User.where(role: 0).all
		elsif @curr_admin.role == "employee"
			@referrers = User.where(role:0).where(status: "Approved").all
			if params[:status] and params[:status] != 'Status'
				@referrers = @referrers.where(status: params[:status])
			end
			@status = params[:status]
		end
		render :show_referrers
	end

	def show_clients
		@curr_admin = current_admin
		if @curr_admin.role == "central"
			@clients = User.where(role: 1).all
		elsif @curr_admin.role == "employee"
			@clients = @curr_admin.users
			#@clients = Form.where(form_type: 3).order("created_at DESC")
			if params[:status] and params[:status] != 'Status'
				@clients = @clients.where(status: params[:status]).all
			end
			@status = params[:status]
		end

		render :show_clients
	end

	def show_referrals
		@curr_admin = current_admin
		@forms = Form.where(:form_type => 2)
		render :show_referrals
	end

	def mark_referrer_status
		id = params[:id]
		status = params[:status]
		@referrer = User.find_by_id(id)
		@form = @referrer.forms.where(form_type: 1).first
		@form.status = status
		@form.save
		@referrer.status = status
		@referrer.save
		message = "Referrer #{@referrer.full_name} has been marked as #{@referrer.status.downcase} by admin #{current_admin.full_name}"
		flash[:notice] = message
		@referrer.events.build(:user_id => @referrer.id, :admin_id => current_admin.id, :message => message)
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@referrer).deliver_now # sends the email
		end

		redirect_to referrers_path
	end

	def mark_client_status
		id = params[:id]
		form_id = params[:form_id]
		status = params[:status]
		@client = User.find_by_id(id)
		@form = Form.find_by_id(form_id)
		@form.status = status
		@client.status = status
		@form.save
		@client.save
		message = "Questionnaire of client #{@client.full_name} has been marked as #{@client.status.downcase} by admin #{current_admin.full_name}"
		flash[:notice] = message
		@client.events.build(:user_id => @client.id, :admin_id => current_admin.id, :message => message)
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@client).deliver_now # sends the email
		end
		redirect_to clients_path
	end

	def mark_form_status
		id = params[:id]
		status = params[:status]
		@form = Form.find(id)
		@form.status = status
		@form.save
		message = "Referral #{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase} by admin #{current_admin.full_name}"
		Admin.find_by_id(current_admin.id).events.build(:admin_id => current_admin.id, :message => message)
		if status == "Approved"
			flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}, next step is to invite as client."
			redirect_to new_user_invitation_path
			return
		else
			flash[:notice] = message
		end
		redirect_to admin_referrals_path
	end
	
	def change_client_phase
		@client = User.find_by_id(params[:id])
		prev_phase = @client.phase
		@client.phase = params[:edit_client]["changed_phase"]
		@client.save
		message = "#{@client.first_name} #{@client.last_name} has been moved from #{prev_phase} to #{@client.phase}"
		@client.events.build(:user_id => :id, :message => message)
		@client.save
		flash[:notice] = message
		redirect_to client_path
	end
	
	def assign_caseworker
		@client = User.find_by_id(params[:id])
		caseworker = params[:edit_client]["assign_caseworker"]
		first, last = caseworker.split(' ')
		caseworker_id = Admin.where(role: 1).where(first_name: first).where(last_name: last).first.id
		
		if !@client.ownerships.where(user_id: params[:id]).empty? && !@client.ownerships.where(user_id: params[:id]).where(admin_id: caseworker_id).empty?
			#means that this ownership already exists!
			flash[:warning] = "#{@client.first_name} #{@client.last_name} has already been assigned to caseworker #{first} #{last}!"
		else
			@client.ownerships.build(:user_id => params[:id], :admin_id => caseworker_id)
			message = "#{@client.first_name} #{@client.last_name} has been assigned to caseworker #{first} #{last}"
			@client.events.build(:user_id => params[:id], :message => message)
			@client.save
			flash[:notice] = message
		end
		redirect_to client_path
	end
	
	def delete_caseworker
		@client = User.find_by_id(params[:id])
		caseworker = params[:caseworker]
		
		first, last = caseworker.split(' ')
		caseworker_id = Admin.where(role: 1).where(first_name: first).where(last_name: last).first.id	
		if !@client.ownerships.where(admin_id: caseworker_id).empty?
			@client.ownerships.where(admin_id: caseworker_id).destroy_all
			message = "Admin #{current_admin.full_name} deleted caseworker #{caseworker} from client #{@client.full_name}"
			flash[:notice] = message
			@client.events.build(:user_id => @client.id, :admin_id => current_admin.id, :message => message)
			@client.save
		end
		redirect_to client_path
	end


	def show_all
		@curr_admin = current_admin
		if @curr_admin == nil
			flash[:notice] = "You must be admin to do that!"
			redirect_to root_path and return
		elsif @curr_admin.role == 'employee'
			flash[:warning] = "You must be central admin to do that!"
			redirect_to root_path and return
		else
			@admins = Admin.all
		end
	end
	
	def show_my_profile
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		render :show_my_profile
	end
	
	def show
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		@client_names = []
		if !@admin.ownerships.empty?
			@admin.ownerships.each do |ownership|
				client_id = ownership.user_id
				@client_names.append(User.find_by_id(client_id).full_name)
			end
		else
			@client_names.append('This caseworker has no clients.')
		end
		render :admin_profile
	end
	
	def admin_settings_edit
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		render :admin_edit_profile
	end
    
	def admin_setting
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		render :admin_setting
	end
    
	def admin_edit_save
		@curr_admin = current_admin
		Admin.update(params[:id], 
		{:first_name => params["admin"]["first_name"], 
		:last_name => params["admin"]["last_name"], 
		:email => params["admin"]["email"], 
		:phone => params["admin"]["phone"], 
		:address => params["admin"]["address"],
		:skype => params["admin"]["skype"]})
		redirect_to :admin_setting
	end
    
	def admin_destroy
		redirect_to destroy_user_session_path
		@admin = Admin.find_by_id(params[:id])
		@admin.destroy
	end
	
	def admin_pass_change
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		render :admin_pass_change
	end 
	
	def admin_pass_save
		@curr_admin = current_admin
		curr = params["admin"]["encrypted_password"]
		if (@curr_admin.valid_password?(curr))
			pass1 = params["admin"]["pass_reset1"]
			pass2 = params["admin"]["pass_reset2"]
			if (pass1 == pass2)
				if (pass1.length > 5)
					new_pass = Admin.create(:password => pass1).encrypted_password
					@curr_admin.encrypted_password = new_pass
					@curr_admin.save
				else 
					flash[:alert] = "Your new password must be longer than 5 characters long."
				end
			else
				flash[:alert] = "Your new password and confirmation password do not match. Please try again."
			end
		else
			flash[:alert] = "Your old password is incorrect. Please try again."
		end
		redirect_to :admin_setting
	end
    
end
