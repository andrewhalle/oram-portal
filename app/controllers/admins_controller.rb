class AdminsController < ApplicationController

	before_filter :authenticate_admin!

	def show_referrers
		@curr_admin = current_admin
		#@referrers = User.where(role: User.roles[:referrer]).where.not(invitation_accepted_at: nil)
		if @curr_admin.role == "central"
			@referrers = User.where(role: 0).all
		elsif @curr_admin.role == "employee"
			@referrers = Form.where(form_type: 1)
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
			@clients = Form.where(form_type: 3).order("created_at DESC")
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
		form_id = params[:form_id]
		status = params[:status]
		@referrer = User.find_by_id(id)
		@form = Form.find_by_id(form_id)
		@form.status = status
		@form.save
		flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@referrer).deliver_now # sends the email
		end
		if status == "Complete"
			
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
		@form.save
		flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@client).deliver_now # sends the email
		elsif status == "Complete"
			@client.phase = "Phase 3"
		end
		redirect_to clients_path
	end

	def mark_form_status
		id = params[:id]
		status = params[:status]
		@form = Form.find(id)
		@form.status = status
		@form.save
		if status == "Approved"
			flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}, next step is to invite as client."
			redirect_to new_user_invitation_path
			return
		else
			flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		end
		redirect_to admin_referrals_path
	end
	
	def change_client_phase
		@client = User.find_by_id(params[:id])
		prev_phase = @client.phase
		@client.phase = params[:edit_client]["changed_phase"]
		@client.save
		flash[:notice] = "You successfully moved #{@client.first_name} #{@client.last_name} from #{prev_phase} to #{@client.phase}"
		newEvent = @client.events.build()
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
	
	def show
		@curr_admin = current_admin
		@admin = Admin.find_by_id(params[:id])
		render :admin_profile
	end
end
