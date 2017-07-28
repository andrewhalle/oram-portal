class UserStatusDefaultIncomplete < ActiveRecord::Migration
  def change
    change_column_default(:users, :status, "Incomplete")
  end
end