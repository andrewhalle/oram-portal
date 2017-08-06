# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
   :rememberable, :trackable, :validatable
  include DeviseInvitable::Inviter
  
  has_many :users
  
  enum role: [:central, :employee]
  
  has_many :ownerships
  has_many :events
  has_many :users, :through => :ownerships
  
  def initialize(attributes = nil)
    super
    events.build(:admin_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} created an account.")
    # Do whatever you want in here.
  end
  before_destroy do
    # if admin_logged_in?
    #   @curr_admin = current_admin
    #   events.build(:user_id => id, :admin_id => @curr_admin.id, :created_at => Time.now, :updated_at => Time.now, :message => "Admin #{@curr_admin.full_name} deleted account of user #{first_name} #{last_name}.")
    # elsif user_logged_in?
    #   @curr_user = current_user
    #   events.build(:user_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} deleted their own account.")
    # end
    Event.create(:created_at => Time.now, :updated_at => Time.now, :message => "Admin #{first_name} #{last_name} deleted their own account.")
    true
  end


  
  # def self.Caseworkers
  #   caseworkers_db = self.all
  #   caseworkers = {}
  #   byebug
  #   caseworkers_db.each do |caseworker|
  #       caseworker["#{caseworker.id}"] = caseworker.full_name
  #   end
  #   byebug
  #   caseworkers
  # end
  
  def self.get_by_full_name(full_name)
    first, last = full_name.split(' ')
    Admin.where(first_name: first).where(last_name: last).first
  end
  

  def get_user_ids
    user_ids = self.users.map do |u|
      u.id
    end
    user_ids
  end
  
  # def get_user_params(param)
  #   user_params = users.map do |u|
  #     u.send(param)
  #   end
  #   user_params
  # end
  
  def full_name
    return "#{first_name}" + " " + "#{last_name}"
  end
  
  #this currently returns an array of dictionaries instead of an activerecord relation.
# 	def get_referrers_associated_with_users
# 		user_names = get_user_params("full_name")
# 		referrals = Form.where(form_type: 2).all
# 		referrers = []
# 		user_names.each do |user_name|
# 			referrals.each do |referral|
# 				if user_name == referral.full_name && referral.status != "Rejected"
# 					referrer = User.where(:id => referral.user_id).first
# 					referrers.append({"first_name" => referrer.first_name, "last_name" => referrer.last_name, "id"=> referrer.id})
# 				end
# 			end
# 		end
# 		referrers
# 	end

end
