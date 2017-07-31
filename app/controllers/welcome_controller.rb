class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      if @user.role == "client"
        @events = Event.where(:user_id => @user.id).all.reverse
      elsif @user.role == "referrer"
        user_ids = @user.clients.map do |c|
          c.id
        end
        @events = Event.where(:admin_id => @user.id).all.reverse
      end
    elsif admin_signed_in?
      @curr_admin = current_admin
      if @curr_admin.role == "central"
        @events = Event.all.reverse
      elsif @curr_admin.role == "employee"
        user_ids = @curr_admin.get_user_ids
        @events = Event.where(:user_id => user_ids).reverse
      end
    end
  end
end
