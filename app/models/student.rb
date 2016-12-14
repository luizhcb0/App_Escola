class Student < ApplicationRecord
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :messages
  has_many :student_users
  has_many :users, through: :student_users
  has_many :option_students
  has_many :options, through: :option_students

  validates :name, presence: true
end
