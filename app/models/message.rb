class Message < ApplicationRecord
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :students

  enum sender_receiver: %w(classroom_student student_classroom)

  validates :text, :sender_receiver, presence: true
  validates :classrooms, :students, presence: true

  # Callback to set the read proprerty false on Create
  before_create :set_not_read

  def set_not_read
    self.read = false
  end
end
