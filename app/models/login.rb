class Login < ApplicationRecord
  has_one :professor
  has_many :student_logins
  has_many :students, through: :student_logins

  has_secure_password
  # there must be a password on create
  validates :password, presence: true, on: :create
  validates :username, :role, presence: true
end
