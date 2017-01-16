require 'rails_helper'

RSpec.describe ReportOption, type: :model do
  describe "Associations" do
    it { should belong_to(:option) }
    it { should belong_to(:report) }
  end

  # Tests just to show how it works
  describe "Notes tests" do
    it "should be able to take notes" do

      option = create(:option)
      student = create(:student)
      report_option = create(:report_option, option: option)
      report = create(:report, student: student, report_options: [report_option])
      # Proving
      expect(report.report_options).to_not be nil
      # This is how you save the report_options.notes field:
      rpt_opt = report.report_options.first
      rpt_opt.note = "texto de teste"
      rpt_opt.save
      # Showing that it works:
      expect(rpt_opt.note).to eq "texto de teste"
      expect(report.reload.report_options.first.note).to eq "texto de teste"
      # This is how you get the option_student object:
      expect(ReportOption.where(
        option_id: option.id).first.note).to eq "texto de teste"
    end
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to report_options from options" do
      option = create(:option)
      student = create(:student)
      report_option = create(:report_option, option: option)
      report = create(:report, student: student, report_options: [report_option])
      expect(report.reload.report_options.size).to eq 1
      option.destroy
      expect(report.reload.report_options.size).to eq 0
      expect(Option.all).to_not include option
      expect(ReportOption.all).to_not include report_option
    end

    it "should delete the references to reports_options from reports" do
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
