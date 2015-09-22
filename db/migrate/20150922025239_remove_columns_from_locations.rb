class RemoveColumnsFromLocations < ActiveRecord::Migration
  def change
  	remove_column :locations, :pickup_date
  	remove_column :locations, :comments
  	remove_column :locations, :extra

  	add_column :locations, :pickup_date, :date
  	add_column :locations, :comments, :text
  	add_column :locations, :extra, :text
  end
end
