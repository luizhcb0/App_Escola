require 'rails_helper'

RSpec.describe "professors/index.html.erb", type: :view do
  before(:each) { assign(:professors, [
    Professor.new(id: 1, user: User.new(name: "Professor1")),
    Professor.new(id: 2, user: User.new(name: "Professor2")),
    Professor.new(id: 3, user: User.new(name: "Professor3")) ])
    render
  }

  it "should display all assigned professors" do
    expect(rendered).to match(/Professor1/)
    expect(rendered).to match(/Professor2/)
    expect(rendered).to match(/Professor3/)
  end
end
