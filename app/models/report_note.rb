class ReportNote < ApplicationRecord
  belongs_to :activity
  belongs_to :report, optional: true

  validates :text, presence: true
end
