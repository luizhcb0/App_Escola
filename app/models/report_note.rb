class ReportNote < ApplicationRecord
  belongs_to :activity
  belongs_to :report

  validates :text, presence: true
end
