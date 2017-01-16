class ReportOption < ApplicationRecord
  belongs_to :option
  belongs_to :report, optional: true
end
