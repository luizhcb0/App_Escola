class Classroom < ApplicationRecord
  has_and_belongs_to_many :professors
  has_and_belongs_to_many :students
  has_and_belongs_to_many :activities

  validates :name, :shift, presence: true
end
