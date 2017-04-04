class Professor < ApplicationRecord
  belongs_to :classroom, optional: true
  has_many :messages

  validates :name, presence: true
end
