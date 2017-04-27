class ReportClip < ApplicationRecord
  belongs_to :report

  has_attached_file :media
  validates_attachment_content_type :media,
    content_type: ["image/jpeg", "image/gif", "image/png", "video/mp4"]
end
