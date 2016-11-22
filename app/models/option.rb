class Option < ApplicationRecord
  belongs_to :activity
  has_many :option_students
  has_many :students, through: :option_students

  validates :name, presence: true
end
