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
  
  def initialize(attributes)
    super(attributes)
    events.build(:admin_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} created an account.")
    save
    # Do whatever you want in here.
  end
  
  def self.Caseworkers
    caseworkers_db = self.where(role: 1).all
    caseworkers = []
    caseworkers_db.each do |caseworker|
        caseworkers.append("#{caseworker.first_name}" + " " + "#{caseworker.last_name}")
    end
    caseworkers
  end
  
  def full_name
    return "#{first_name}" + " " + "#{last_name}"
  end
  
end
