class AddCountryAndLanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :languages, :text
  end
end
