class Api::V1::StudentSerializer < ActiveModel::Serializer
  attributes :id, :name,  :address, :birthday, :avatar, :absence
  
  has_many :student_users, dependent: :destroy
  has_many :users, through: :student_users

end
