class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  enum role: {admin: 0, donor: 1, cyclist: 2}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first, presence: true, on: :update
  validates :last,  presence: true, on: :update
  validates :email, presence: true, on: :update
  validates :role,  presence: true, on: :update
  validates :phone, presence: true, on: :update

  validates :first, length:   {maximum: 255}
  validates :last,  length:   {maximum: 255}
  validates :email, length:   {maximum: 255}

  validates :email, format:   VALID_EMAIL_REGEX
end
