module AdminsHelper
    
	def mark_status(user, status, type)
		message = "Form of user #{@client.full_name} has been marked as #{status.downcase} by admin #{current_admin.full_name}"
		if !user.forms.empty?
			form = user.forms.where(form_type: type).first
			if !form.nil?
			    form.status = status
			    form.save
			end
		end
		user.status = status
		user.save

		e = user.events.build(:user_id => user.id, :admin_id => current_admin.id, :message => message)
		e.save
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(user).deliver_now # sends the email
		end
		flash[:notice] = message
	end
end
