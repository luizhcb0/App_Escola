require 'rails_helper'

RSpec.describe "options/index.html.erb", type: :view do
  before(:each) {
    create(:option)
    assign(:options, Option.all)
    render
  }

  it "should display all option professors" do
    expect(rendered).to match(/Lunch/)
  end
end
