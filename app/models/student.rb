class Student < ApplicationRecord
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :messages
  has_many :student_users, dependent: :destroy
  has_many :users, through: :student_users
  has_many :reports

  validates :name, presence: true
end
