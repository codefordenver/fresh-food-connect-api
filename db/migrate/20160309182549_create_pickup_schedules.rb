class CreatePickupSchedules < ActiveRecord::Migration
  def change
    create_table :pickup_schedules do |t|
      t.string :zip_code
      t.text :notification_text
      t.string :pickup_time_range_start
      t.string :pickup_time_range_end
      t.date :pickup_date_range_start
      t.date :pickup_date_range_end
      t.string :notification_time
    end
  end
end
