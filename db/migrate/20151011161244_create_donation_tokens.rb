class CreateDonationTokens < ActiveRecord::Migration
  def change
    create_table :donation_tokens do |t|
      t.integer :user_id
      t.datetime :expires_at
      t.datetime :used_at
      t.integer :donation_id
      t.string :token

      t.timestamps
    end

    add_index :donation_tokens, :token
  end
end
