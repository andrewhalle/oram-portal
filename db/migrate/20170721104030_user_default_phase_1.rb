class UserDefaultPhase1 < ActiveRecord::Migration
  def change
    change_column_default(:users, :phase, "Phase 1")
  end
end