class DonationToken < ActiveRecord::Base
  belongs_to :user
  belongs_to :donation
  belongs_to :location

  before_create :generate_token
  before_create :set_expires_at

  private

  def generate_token
    begin
      self[:token] = Digest::SHA256.hexdigest("#{user_id}-#{Time.now.to_i}-#{SecureRandom.hex}")
    end while DonationToken.exists?(:token => self[:token])
  end

  def set_expires_at
    hrs = (ENV["DONATION_TOKEN_EXPIRATION"] || 60).to_i
    self[:expires_at] = hrs.hours.from_now
  end
end