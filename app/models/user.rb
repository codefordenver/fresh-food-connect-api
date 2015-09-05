class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  enum role: {admin: 0, donor: 1, cyclist: 2}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first, presence: true
  validates :first, length: {maximum: 255}
  validates :last,  presence: true
  validates :last,  length: {maximum: 255}
  validates :email, presence: true
  validates :email, length: {maximum: 255}
  validates :email, format: VALID_EMAIL_REGEX
  validates :role,  presence: true
  validates :phone, presence: true
end
