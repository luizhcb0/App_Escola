class Message < ApplicationRecord
  has_many :message_connections
  has_many :students, through: :message_connections
  has_many :classrooms, through: :message_connections

  enum sender_receiver: %w(classroom_student student_classroom)

  validates :text, :sender_receiver, presence: true
  validates :message_connections, presence: true

  # Callback to set the read proprerty false on Create
  before_create :set_not_read

  def set_not_read
    self.read = false
  end
end
