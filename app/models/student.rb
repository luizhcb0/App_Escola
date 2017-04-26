class Student < ApplicationRecord
  has_and_belongs_to_many :classrooms

  has_many :student_users, dependent: :destroy
  has_many :users, through: :student_users
  has_many :reports

  has_many :message_students
  has_many :messages, through: :message_students

  has_attached_file :avatar,
    default_url: ActionController::Base.helpers.asset_path("no_avatar.png")
  validates_attachment_content_type :avatar,
    content_type: ["image/jpeg", "image/gif", "image/png"]

  validates :name, presence: true
end
