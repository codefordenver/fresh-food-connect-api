class AddLocationIdToDonationTokens < ActiveRecord::Migration
  def change
    add_column :donation_tokens, :location_id, :integer
  end
end
