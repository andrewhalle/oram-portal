class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def show_referrers
		@referrers = User.with_role :referrer
	end

	def mark_referrer_approved
		id = [params[:id]]
		@referrer = Users.find_by_id(id)
		@referrer.approved = true
		@referrer.save
		redirect_to :show_referrers
	end

	def mark_referrer_rejected
		id = [params[:id]]
		@referrer = Users.find_by_id(id)
		@referrer.approved = false
		@referrer.save
		redirect_to :show_referrers
	end
end
