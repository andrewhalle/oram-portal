class ResetPassword < ActiveRecord::Migration
  def change
    add_column :admins, :pass_reset1, :string
    add_column :admins, :pass_reset2, :string
  end
end
