class Activity < ApplicationRecord
  belongs_to :activity_category
  has_many :options
  has_and_belongs_to_many :classrooms
  has_many :report_notes

  validates :name, presence: true
end
