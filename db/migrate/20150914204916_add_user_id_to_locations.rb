class AddUserIdToLocations < ActiveRecord::Migration
  def up
    add_column :locations, :user_id, :integer
    add_index :locations, :user_id
    add_foreign_key :locations, :users
  end

  def down
  end
end
