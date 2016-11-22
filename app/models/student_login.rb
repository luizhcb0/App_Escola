class StudentLogin < ApplicationRecord
  belongs_to :student
  belongs_to :login
end
