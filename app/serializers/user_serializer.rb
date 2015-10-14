class UserSerializer < ActiveModel::Serializer
  attributes :id, :first, :last, :email, :role, :phone, :created_at, :updated_at

  has_many :locations, :donations
end
