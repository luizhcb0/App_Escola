class Professor < ApplicationRecord
  belongs_to :classrooms;
  has_many :messages
  
  validates :name, presence: true
end
