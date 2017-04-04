require 'rails_helper'

RSpec.describe "schools/index.html.erb", type: :view do
  before(:each) { assign(:schools, [
    School.new(id: 1, user: build(:user, name: "Escola1")),
    School.new(id: 2, user: build(:user, name: "Escola2")),
    School.new(id: 3, user: build(:user, name: "Escola3")) ])
    render
  }

  it "should display all assigned schools" do
    expect(rendered).to match(/Escola1/)
    expect(rendered).to match(/Escola2/)
    expect(rendered).to match(/Escola3/)
  end

end
