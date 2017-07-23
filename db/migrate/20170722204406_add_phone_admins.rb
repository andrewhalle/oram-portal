class AddPhoneAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :phone, :string, default: ""
    add_column :admins, :address, :string, default: ""
    add_column :admins, :skype, :string, default: ""
  end
end
