class CreateDonationPreferences < ActiveRecord::Migration
  def change
    create_table :donation_preferences do |t|
      t.integer     :size
      t.text        :comments

      t.timestamps  null: false
    end
  end
end
