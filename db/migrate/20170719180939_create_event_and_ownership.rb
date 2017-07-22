class CreateEventAndOwnership < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :message
      t.timestamps
    end
    
    create_table :ownerships do |t|
      t.belongs_to :admin
      t.belongs_to :user
    end
  end
end
