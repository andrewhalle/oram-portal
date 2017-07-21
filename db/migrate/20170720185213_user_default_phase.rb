class UserDefaultPhase < ActiveRecord::Migration
  def change
    change_column_default(:users, :phase, "Phase 3")
  end
end