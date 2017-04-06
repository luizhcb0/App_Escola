class Message < ApplicationRecord
  has_and_belongs_to_many :classrooms
  has_many :message_students
  has_many :students, through: :message_students

  enum sender_receiver: %w(classroom_student student_classroom)

  validates :text, :sender_receiver, presence: true
  validates :classrooms, :students, presence: true

end
