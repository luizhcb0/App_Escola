class Report < ApplicationRecord
  belongs_to :student
  has_and_belongs_to_many :suboptions
  has_many :report_notes

  accepts_nested_attributes_for :report_notes

  # Callback to set the read proprerty false on Create
  before_create :set_date

  def set_date
    self.date = Date.today
  end
end
