class Suboption < ApplicationRecord
  belongs_to :option, optional: true
  has_and_belongs_to_many :reports
  validates :name, presence: true
end
