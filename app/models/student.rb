class Student < ApplicationRecord
  has_and_belongs_to_many :classrooms

  has_many :student_users, dependent: :destroy
  has_many :users, through: :student_users
  has_many :reports

  has_and_belongs_to_many :messages

  validates :name, presence: true
end
