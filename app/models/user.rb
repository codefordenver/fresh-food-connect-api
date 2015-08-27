class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLE_ADMIN    = 1
  ROLE_GARDENER = 2
  ROLE_CYCLIST  = 3
end
