class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :donations
  has_many :locations

  include DeviseTokenAuth::Concerns::User

  enum role: { admin: 0, donor: 1, cyclist: 2 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email,     presence: true, length: { maximum: 255 }, format: VALID_EMAIL_REGEX
end
