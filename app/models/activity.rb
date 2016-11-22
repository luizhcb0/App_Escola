class Activity < ApplicationRecord
  belongs_to :activity_category
  has_many :options
  has_and_belongs_to_many :classrooms

  validates :name, presence: true
end
