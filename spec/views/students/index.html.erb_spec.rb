require 'rails_helper'

RSpec.describe "students/index.html.erb", type: :view do
  before(:each) { assign(:students, [
    Student.new(id: 1, person: Person.new(name: "Student1")),
    Student.new(id: 2, person: Person.new(name: "Student2")),
    Student.new(id: 3, person: Person.new(name: "Student3")) ])
    render
  }

  it "should display all assigned Students" do
    expect(rendered).to match(/Student1/)
    expect(rendered).to match(/Student2/)
    expect(rendered).to match(/Student3/)
  end
end
