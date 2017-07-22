# == Schema Information
#
# Table name: forms
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  form_type              :integer
#  status                 :string
#  first_name             :string
#  last_name              :string
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_form_json    :string
#  encrypted_form_json_iv :string
#

class Form < ActiveRecord::Base
  belongs_to :user
  attr_encrypted :form_json, :key => ENV["form_key"], :unless => Rails.env.test?

  def getFormHash
  	return form_json && JSON.parse(form_json)
  end
  
  def full_name
    return "#{first_name}" + " " + "#{last_name}"
  end
  
end
