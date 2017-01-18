class Report < ApplicationRecord
  belongs_to :student
  has_and_belongs_to_many :options
end
