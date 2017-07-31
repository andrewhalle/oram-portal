class UpdocForeignKey < ActiveRecord::Migration
  def change
    add_column :updocs, :user_id, :integer
  end
end