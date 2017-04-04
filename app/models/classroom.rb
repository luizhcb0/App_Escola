class Classroom < ApplicationRecord
  has_many :professors
  has_and_belongs_to_many :students
  has_and_belongs_to_many :activities
  belongs_to :user

  validates :shift, presence: true
end
