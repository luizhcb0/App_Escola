require 'rails_helper'

RSpec.describe ReportNote, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:text) }
  end

  describe "Associations" do
    it { should belong_to(:activity) }
    it { should belong_to(:report) }
  end
end
