class MessageConnection < ApplicationRecord
  belongs_to :classroom
  belongs_to :student
  belongs_to :message
end
