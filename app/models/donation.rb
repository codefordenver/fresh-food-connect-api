class Donation < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  validates :size, presence: true, inclusion: { in: %w(small medium large) }

  enum size: { small: 1, medium: 2, large: 3 }


  def self.within_time_range(from, to)
    from = Time.parse(from)
    to   = Time.parse(to)

    unless from < to
      raise RangeError "Range is invalid: from: #{from} is greater than #{to}"
    end

    where(created_at: from..to)
  end

end
