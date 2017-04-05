require 'rails_helper'

RSpec.describe "schools/index.html.erb", type: :view do
  before(:each) { assign(:schools, [
    School.new(id: 1, name: "Escola1", user: build(:user)),
    School.new(id: 2, name: "Escola2", user: build(:user)),
    School.new(id: 3, name: "Escola3", user: build(:user)) ])
    render
  }

  it "should display all assigned schools" do
    expect(rendered).to match(/Escola1/)
    expect(rendered).to match(/Escola2/)
    expect(rendered).to match(/Escola3/)
  end

end
