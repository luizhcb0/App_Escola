class Message < ApplicationRecord
  belongs_to :classroom
  belongs_to :student
  has_many :students, through: :message_students

  validates :text, presence: true
  
  # Callback to set the read proprerty false on Create
  before_create :set_not_read

  def set_not_read
    self.read = false
  end
end
