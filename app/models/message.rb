class Message < ApplicationRecord
  belongs_to :professor
  has_and_belongs_to_many :students

  validates :text, presence: true
end
