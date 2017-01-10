class Option < ApplicationRecord
  belongs_to :activity
  has_many :option_students
  has_many :students, through: :option_students
  has_many :suboptions, class_name: "Option", foreign_key: "option_id"
  belongs_to :parent, class_name: "Option", optional: true, foreign_key: "option_id"

  accepts_nested_attributes_for :suboptions, allow_destroy: true,

    reject_if: ->(attrs) { attrs['name'].blank? }

  validates :name, presence: true
end
