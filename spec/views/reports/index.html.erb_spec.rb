require 'rails_helper'

RSpec.describe "reports/index.html.erb", type: :view do
  before(:each) {
    report = create(:report, student: create(:student, name: "Student1"))
    assign(:reports, Report.all)
    params[:student_id] = report.student_id
    render
  }

  it "should display all report Students" do
    expect(rendered).to match(/Student1/)
  end
end
