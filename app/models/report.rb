class Report < ApplicationRecord
  belongs_to :student
  has_and_belongs_to_many :suboptions
  has_many :report_notes

  accepts_nested_attributes_for :report_notes, allow_destroy: true,
    reject_if: ->(attrs) { attrs['text'].blank? }

  # Validates the existence of suboptions to save
  validate :at_least_one_suboption

  # Callback to set the read proprerty false on Create
  before_create :set_date

  private
  def set_date
    self.date = Date.today
  end

  def at_least_one_suboption
    if suboptions.size < 1
      errors.add :base, "The report can't be empty"
    end
  end
end
