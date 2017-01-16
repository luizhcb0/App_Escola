require 'rails_helper'

RSpec.describe Option, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:activity) }
    it { should have_many(:report_options) }
    it { should have_many(:suboptions) }
    it { should belong_to(:parent) }
    it { should accept_nested_attributes_for(:suboptions) }
  end

  describe "Callbacks" do
    it "before_create" do
      suboption = create(:option)
      option = create(:option, suboptions:[suboption])
      option.run_callbacks(:create) {false}
      expect(option.suboptions.first.activity_id).to eq option.activity_id
    end

    it "before_update" do
      suboption = create(:option)
      option = create(:option, suboptions:[suboption])
      option.update(activity_id: 5)
      option.run_callbacks(:update) {false}
      expect(option.suboptions.first.activity_id).to eq option.activity_id
    end
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to options from report_options" do
      option = create(:option)
      student = create(:student)
      report_option = create(:report_option, option: option)
      report = create(:report, student: student, report_options: [report_option])
      expect(report.reload.report_options.size).to eq 1
      option.destroy
      expect(report.reload.report_options.size).to eq 0
    end

    it "should delete references to suboptions from options" do
      option = create(:option)
      suboption = create(:option, parent: option)
      option.destroy
      expect(Option.all).to_not include option
      expect(Option.all).to_not include suboption
    end
  end

  describe "Consistency" do
    it "should have saved parent and child" do
      option_child = create(:option)
      option = create(:option, suboptions: [option_child])
      option.save
      expect(Option.all).to include option
      expect(Option.all).to include option_child
    end
  end

end
