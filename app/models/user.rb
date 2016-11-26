# == Schema Information
#
# Table name: users
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
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  status                 :string           default("Incomplete")
#

class User < ActiveRecord::Base
  rolify :role_cname => 'UserRole'
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :invitable, :database_authenticatable, :recoverable,
     :rememberable, :trackable, :validatable

    has_many :forms
    
    def full_name
        first_name + " " + last_name
    end

    def gender_identity_options
    	return ["Male", "Female", "Cisgender", "Transgender", "Genderqueer", "Intersex", "Heterosexual", "Lesbian", "Gay", "Bisexual", "Queer", "Decline to answer"]
    end

    def LGBTIQ_options
      return ["Transgender", "Genderqueer", "Intersex", "Heterosexual", "Lesbian", "Gay"]
    end

    def referrer_contact_options
      return ["Oram invited me", "I requested this", "I completed an ORAM training", "Other"]
    end

    def referrer_LGBTI_social_media
      return ["Scruff", "Manjam", "Planet Romeo", "Hornet", "Gaydar", "OkCupid", "Manhunt", "GROWLr", "Other", "Prefer not to say"]
    end

    def all_countries
      return CS.countries
    end


end
