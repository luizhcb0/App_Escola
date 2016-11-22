class Professor < ApplicationRecord
  has_one :school
  belongs_to :person
  belongs_to :login
  has_and_belongs_to_many :classrooms
  has_many :messages
end
