require 'rails_helper'

RSpec.describe "classrooms/edit.html.erb", type: :view do
  before(:each) {
    assign(:classroom, build(:classroom, id: 2) )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
