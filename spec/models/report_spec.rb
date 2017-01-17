require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "Associations" do
    it { should belong_to(:student) }
    it { should have_many(:report_options) }
    it { should accept_nested_attributes_for(:report_options) }
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

    it "should delete the references to report_options from reports" do
      option = create(:option)
      student = create(:student)
      report_option = create(:report_option, option: option)
      report = create(:report, student: student, report_options: [report_option])
      expect(report).to_not eq nil
      expect(Report.all).to include report
      report.destroy
      expect(Report.all).to_not include report
      expect(ReportOption.all).to_not include report_option
    end

  end
end
