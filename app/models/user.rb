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
#  role                   :integer
#  dropbox_session        :string
#  case_document          :string
#  phase                  :string

class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	
  	devise :invitable, :database_authenticatable, :recoverable,
     :rememberable, :trackable, :validatable

    enum role: [:referrer, :client]

    has_many :forms
    has_many :referrals, :foreign_key => "user_id", :class_name => "Referral"
    has_many :clients, :through => :referrals
    has_many :events
    has_many :ownerships
    has_many :admins, :through => :ownerships
    has_many :notes, dependent: :destroy
    has_many :updocs
    
    mount_uploader :case_document, CaseDocumentUploader

    def initialize(attributes = nil)
      super
      events.build(:user_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} created an account.")
    end
    
    before_destroy do
      # if admin_logged_in?
      #   @curr_admin = current_admin
      #   events.build(:user_id => id, :admin_id => @curr_admin.id, :created_at => Time.now, :updated_at => Time.now, :message => "Admin #{@curr_admin.full_name} deleted account of user #{first_name} #{last_name}.")
      # elsif user_logged_in?
      #   @curr_user = current_user
      #   events.build(:user_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} deleted their own account.")
      # end
      Event.create(:user_id => id, :created_at => Time.now, :updated_at => Time.now, :message => "User #{first_name} #{last_name} deleted their own account.")
      true
    end
    
    #Adding stuff for tracker 
    def self.Application_phases
      return {
        "Phase 1" => "Applicant Vetting", 
        "Phase 2" => "Client Engagement or Client Rejected", 
        "Phase 3" => "ORAM Preparing Client Case", 
        "Phase 4" => "Case Submitted", 
        "Phase 5" => "UNHCR Interview", 
        "Phase 6" => "Recognized Refugee",
        "Phase 7" => "Case Rejected by UNHCR",
        "Phase 8" => "Client Approved for Resettlement",
        "Phase 9" => "Client Resettled",
        "Phase 10" => "Case Closed"
      }
    end 
    
    def self.Application_phases_array
      array = [] 
      self.Application_phases.each {|key, value|
        array.append("#{key}: #{value}")
      }
      array
    end
    
    def full_name
        first_name + " " + last_name
    end
    
    # def self.get_id_by_name(full_name)
    #   first, last = full_name.split(' ')
    #   self.where(first_name: first).where(last_name: last).first.id
    # end
    
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

    def client_languages
      return ["English", "Arabic", "Persian/Farsi", "Turkish"]
    end

    def sex
      return ["Male", "Female", "Intersex"]
    end

    def turkey_legal_status
      return ["Undocumented (no legal status)", "Legal Temporary Resident (Non-Citizen)", "Legal Long-Term Resident (Non-Citizen)", "Legal Citizen", "Unsure"]
    end

    def living_situation
      return ["Alone", "With a roommate(s)", "With a partner", "Unsure"]
    end

    def refugee_claim
      return ["Race",
              "Religion",
              "Ethnicity",
              "Political Opinion",
              "Membership to a Particular Social Group Non-LGBTI Related",
              "Membership to a Particular Social Group LGBTI Related",
              "Unsure"]
    end

    def yes_no_unsure
      return ["Yes", "No", "Unsure"]
    end

    def sexual_orientation
      return ["Heterosexual", "Gay", "Lesbian", "Bisexual", "Queer", "Asexual"]
    end

    def client_gender_identity
      return ["Male", "Female", "Genderqueer", "Third Gender", "Unsure"]
    end

    def client_partner
      return ["Yes, a same-sex partner", "Yes, an opposite-sex partner", "No", "Unsure"]
    end

    def client_openness
      return ["Only their close friends?", "Only people they know?", "Society in general?", "Unsure"]
    end

    def client_dangers
      return ["Family Members in their Country of Origin",
              "Family Members in Turkey",
              "Teachers/Classmates in their Country of Origin",
              "Teachers/Classmates in Turkey",
              "Community Leaders in their Country of Origin",
              "Community Leaders in Turkey",
              "Religious Leaders in their Country of Origin",
              "Religious Leaders in Turkey",
              "State Officials in their Country of Origin",
              "State Officials in Turkey",
              "Co-Workers in their Country of Origin",
              "Co-Workers in Turkey",
              "Other Members of the Wider Society in their Country of Origin",
              "Other Members of the Wider Society in Turkey"]
    end

    def client_incident
      return ["Isolated Incident", "Occurred Multiple Times", "Unsure"]
    end

    def mental_illness
      return ["Depression", "Post Traumatic Stress Disorder", "Bipolar Disorder", "Other"]
    end

    def arrest
      return ["Police and Other Governmental Forces e.g. the Army.",
              "Non-State Paramilitary Groups",
              "Religious Figures",
              "Unsure"]
    end

    def documentary_evidence
      return ["Police Reports and Documentation Related to Court Cases",
              "Hospital Reports/ Medical Records",
              "Threat Letters",
              "Documentation of Injuries e.g. Photos",
              "Other"]
    end

    def no_questionnaire_relationships
      return ["Friend of a Friend", "Through Social Media e.g. Facebook, Twitter, Instagram etc.",
              "Through Social Dating Platforms e.g. Hornet, Manjam etc.", "Other"]
    end

    def yes_questionnaire_relationships
      return ["Colleague",
              "Fellow Activist",
              "Co-worker",
              "Acquaintance",
              "Friend",
              "Close Friend",
              "Occasional Partner",
              "Boyfriend/Girlfriend",
              "Partner",
              "Former Partner",
              "Spouse"]
    end

    def professional_capacity
      return ["UNHCR", "ASAM", "DGMM", "Other"]
    end

    def relationship_level
      return ["Very Good Friends", "Friends", "Acquaintances", "We Have Met Once"]
    end

    def getFormHash(form)
      return form && form.getFormHash
    end

    def self.remove_unsure(arr)
      arr.delete("Unsure")
      return arr
    end

    def self.they_to_you(arr)
      arr.each do |line|
        if line.include? "they"
          line.replace(line.sub("they", "you"))
        end
        if line.include? "their"
          line.replace(line.sub("their", "your"))
        end
      end
      return arr
    end
end
