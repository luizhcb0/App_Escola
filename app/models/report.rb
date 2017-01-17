class Report < ApplicationRecord
  belongs_to :student, dependent: :delete
  has_many :report_options, dependent: :destroy

  accepts_nested_attributes_for :report_options, allow_destroy: true
end
