require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "Associations" do
    it { should belong_to(:student) }
    it { should have_and_belong_to_many(:options) }
    it { should have_many(:report_notes) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to reports from students" do
      student = create(:student)
      report = create(:report, student: student)
      expect(report).to_not eq nil
      expect(Report.all).to include report
      student.destroy
      expect(Report.all).to_not include report
    end

    it "should delete the references to reports from options" do
      option = create(:option)
      report = create(:report, options:[option])
      expect(option.reload.reports.size).to eq 1
      report.destroy
      expect(option.reload.reports.size).to eq 0
    end

  end
end
