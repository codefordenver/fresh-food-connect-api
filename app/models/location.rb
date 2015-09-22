class Location < ActiveRecord::Base
  has_many :donations
  belongs_to :user
  validates_presence_of :user_id
end
