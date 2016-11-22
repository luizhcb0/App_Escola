class Student < ApplicationRecord
  belongs_to :person
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :messages
  has_many :student_logins
  has_many :logins, through: :student_logins
  has_many :option_students
  has_many :options, through: :option_students

  validates :father_name, :mother_name, presence: true
end
