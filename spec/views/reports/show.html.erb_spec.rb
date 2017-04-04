require 'rails_helper'

RSpec.describe "reports/show.html.erb", type: :view do
  before(:each) {
    view.extend SessionsHelper
    # needs to be create because of the timestamp
    student = create(:student, users: [create(:user)])
    view.log_in(student.users[0])
    assign(:report, create(:report, student: student, suboptions: [create(:suboption)]))
    assign(:params, {student_id: student.id, date: Date.today})
    render
    # render :html, locals: { params: { student_id: student.id, date: Date.today } }
  }

  it "should show report attributes" do
    expect(rendered).to match(/Student/)     # student name
    # expect(rendered).to match(/Categoria/)     # ActivityCategory name
    expect(rendered).to match(/Atividade/)     # Activity name
    expect(rendered).to match(/Lunch/)     # Option name
    expect(rendered).to match(/sub/)     # Suboption name
  end
end
