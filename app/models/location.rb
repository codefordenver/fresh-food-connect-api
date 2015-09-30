class Location < ActiveRecord::Base
  has_many :donations
  belongs_to :user
  validates_presence_of :user_id

  enum pickup_day: ["Sunday", "Monday", "Tuesday", "Wednesday", 
  									"Thursday", "Friday", "Saturday"]
end
