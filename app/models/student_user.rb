class StudentUser < ApplicationRecord
  belongs_to :student
  belongs_to :user, dependent: :delete
end
