class Suboption < ApplicationRecord
  belongs_to :option, optional: true

  validates :name, presence: true
end
