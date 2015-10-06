class Location < ActiveRecord::Base
  has_many :donations
  belongs_to :user

  enum pickup_day: ["Sunday", "Monday", "Tuesday", "Wednesday", 
  									"Thursday", "Friday", "Saturday"]
end
