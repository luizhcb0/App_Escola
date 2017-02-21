class MessageStudent < ApplicationRecord
  belongs_to :message
  belongs_to :student

  # Callback to set the read proprerty false on Create
  before_create :set_not_read

  def set_not_read
    self.read = false
  end
end
