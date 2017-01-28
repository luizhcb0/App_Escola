require 'rails_helper'

RSpec.describe "classrooms/new.html.erb", type: :view do
  before(:each) {
    professor = create(:professor)
    assign(:classroom, Classroom.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
