class AddForeignKeysToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :location_id, :integer, null: false, index: true
    add_foreign_key :donations, :locations
    add_column :donations, :user_id, :integer, null: false, index: true
    add_foreign_key :donations, :users
  end
end
