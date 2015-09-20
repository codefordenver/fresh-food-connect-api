class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |table|
      table.integer :size, null: false
      table.text :comments

      table.timestamps null: false
    end
  end
end
