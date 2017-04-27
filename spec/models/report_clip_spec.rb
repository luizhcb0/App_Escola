require 'rails_helper'

RSpec.describe ReportClip, type: :model do
  describe "Associations" do
    it { should belong_to(:report) }
  end

  describe "Attachments" do
    it { should have_attached_file(:media) }
  end

  describe "Validations" do
    it { should validate_attachment_content_type(:media).
                allowing('image/jpeg', 'image/gif', 'image/png', 'video/mp4').
                rejecting('text/plain', 'text/xml') }
  end
end
