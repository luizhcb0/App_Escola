class Clip < ApplicationRecord
  has_and_belongs_to_many :reports

  has_attached_file :media
  validates_attachment_content_type :media,
    content_type: ["image/jpeg", "image/gif", "image/png", "video/mp4"]

  validates :media, presence: true
end
