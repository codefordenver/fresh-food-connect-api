class AddPickupDayToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :pickup_day, :integer
  end
end
