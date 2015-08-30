class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.float       :weight
      t.date        :pickedUpAt

      t.timestamps  null: false
    end
  end
end
