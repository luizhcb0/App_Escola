require 'rails_helper'

RSpec.describe "reports/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:report, create(:report, suboptions: [create(:suboption)]))
    render
  }

  it "should show report attributes" do
    expect(rendered).to match(/Student/)     # student name
    expect(rendered).to match(/Categoria/)     # ActivityCategory name
    expect(rendered).to match(/Atividade/)     # Activity name
    expect(rendered).to match(/Lunch/)     # Option name
    expect(rendered).to match(/sub/)     # Suboption name
  end
end
