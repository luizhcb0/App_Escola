class Student < ApplicationRecord
  has_and_belongs_to_many :classrooms

  has_many :student_users, dependent: :destroy
  has_many :users, through: :student_users
  has_many :reports

  has_many :message_students
  has_many :messages, through: :message_students

  validates :name, presence: true
end
