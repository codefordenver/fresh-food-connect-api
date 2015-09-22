class RemoveRouteIdFromLocations < ActiveRecord::Migration
  def change
  	remove_column :locations, :route_id
  end
end
