class UserCalendarId < ActiveRecord::Migration
  def change
    add_column :users, :calendar_id, :string, default: ""
  end
end
