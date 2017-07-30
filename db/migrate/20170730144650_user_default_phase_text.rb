class UserDefaultPhaseText < ActiveRecord::Migration
  def change
    change_column_default(:users, :phase, "#{User.Application_phases_array[0]}")
  end
end