require 'rails_helper'

RSpec.describe "reports/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:report, create(:report))
    render
  }

  it "should show report student name" do
    expect(rendered).to match(/Student/)     # student name
  end
end
