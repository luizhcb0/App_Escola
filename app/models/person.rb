class Person < ApplicationRecord
  has_one :professor

  validates :name, presence: true
end
