class Login < ApplicationRecord
  has_one :professor
  has_many :student_logins
  has_many :students, through: :student_logins

  validates :username, :password, :role, presence: true
end
