class Professor < ApplicationRecord
  has_one :school
  belongs_to :user
  has_and_belongs_to_many :classrooms
  has_many :messages
end
