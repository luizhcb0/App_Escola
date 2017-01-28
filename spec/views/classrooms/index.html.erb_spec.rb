require 'rails_helper'

RSpec.describe "classrooms/index.html.erb", type: :view do
  before(:each) {
    create(:classroom)
    assign(:classrooms, Classroom.all)
    render
  }

  it "should display all classroom professors" do
    expect(rendered).to match(/Sala Teste/)
  end
end
