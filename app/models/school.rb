class School < ApplicationRecord
  belongs_to :professor

  validates :name, presence: true
end
