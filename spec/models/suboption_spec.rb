require 'rails_helper'

RSpec.describe Suboption, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:option) }
    it { should have_and_belong_to_many(:reports) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to options from suboptions" do
      option = create(:option)
      suboption = create(:suboption, option: option)
      expect(option.suboptions.first).to eq suboption
      suboption.destroy
      expect(option.suboptions).to eq []
      expect(Suboption.all).to_not include suboption
    end

    it "should delete the references to suboptions from reports" do
      suboption = create(:suboption)
      report = create(:report, suboptions: [suboption])
      expect(report.reload.suboptions.size).to eq 1
      suboption.destroy
      expect(report.reload.suboptions.size).to eq 0
    end

    it "should delete references to suboptions from options" do
      option = create(:option)
      suboption = create(:suboption, option: option)
      option.destroy
      expect(Option.all).to_not include option
      expect(Suboption.all).to_not include suboption
    end
  end
end
