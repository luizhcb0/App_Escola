class Person < ApplicationRecord
  has_one :professor
  has_one :student

  validates :name, presence: true
end
