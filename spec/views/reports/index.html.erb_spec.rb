require 'rails_helper'

RSpec.describe "reports/index.html.erb", type: :view do
  before(:each) {
    create(:report, student: create(:student, name: "Student1"))
    create(:report, student: create(:student, name: "Student2"))
    create(:report, student: create(:student, name: "Student3"))
    assign(:reports, Report.all)
    render
  }

  it "should display all report Students" do
    expect(rendered).to match(/Student1/)
    expect(rendered).to match(/Student2/)
    expect(rendered).to match(/Student3/)
  end
end
