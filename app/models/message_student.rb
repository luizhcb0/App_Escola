class MessageStudent < ApplicationRecord
  belongs_to :message
  belongs_to :student
end
