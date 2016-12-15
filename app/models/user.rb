class User < ApplicationRecord
  has_one :professor
  has_many :student_users
  has_many :students, through: :student_users
  belongs_to :role

  has_secure_password
  # there must be a password on create
  validates :password, presence: true, on: :create
  validates :name, :email, :role, presence: true
end
