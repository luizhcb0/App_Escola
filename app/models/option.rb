class Option < ApplicationRecord
  belongs_to :activity
  # has_many :option_students
  # has_many :students, through: :option_students
  has_many :report_options
  has_many :suboptions, class_name: "Option", foreign_key: "option_id"
  belongs_to :parent, class_name: "Option", optional: true, foreign_key: "option_id"
  accepts_nested_attributes_for :suboptions, allow_destroy: true,
    reject_if: ->(attrs) { attrs['name'].blank? }

  validates :name, presence: true

  # after_initialize :set_defaults
  before_create :set_suboptions_activity
  before_update :set_suboptions_activity

  def set_suboptions_activity
    suboptions.each do |child|
      child.activity_id = self.activity_id
    end
  end
end
