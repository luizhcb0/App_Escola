class Professor < ApplicationRecord
  belongs_to :classroom
  has_many :messages

  validates :name, presence: true
end
