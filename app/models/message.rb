class Message < ApplicationRecord
  belongs_to :professor
  has_many :message_students
  has_many :students, through: :message_students

  validates :text, presence: true
end
