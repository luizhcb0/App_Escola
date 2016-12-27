class School < ApplicationRecord
  belongs_to :professor, dependent: :destroy

  validates :name, presence: true
end
