class Donation < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  # 0 is Nothing to Donate
  # 1 is Small donation
  # 2 is Medium donation
  # 3 is Large Donation
  validates :size, presence: true, inclusion: { in: 0..3 }

  def self.within_time_range(from, to)
    from = Time.parse(from)
    to   = Time.parse(to)

    unless from < to
      raise RangeError "Range is invalid: from: #{from} is greater than #{to}"
    end

    where(created_at: from..to)
  end

  def self.with_quantity
    where("size > 0");
  end

end
