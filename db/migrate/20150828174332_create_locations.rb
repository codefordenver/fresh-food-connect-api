class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :address,     null: false, default: "" 
      t.string  :city,        null: false, default: ""
      t.string  :state,       null: false, default: ""
      t.string  :zipcode,     null: false, default: ""
      t.text    :comments,    null: false, default: ""
      t.text    :extra,       null: false, default: ""
      t.integer :route_id,    null: false
      t.float   :latitude    
      t.float   :longitude   
      t.date    :pickup_date, null: false

      t.timestamps null: false
    end
  end
end
