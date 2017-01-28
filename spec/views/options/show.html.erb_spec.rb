require 'rails_helper'

RSpec.describe "options/show.html.erb", type: :view do
  before(:each) {
    assign(:option, create(:option, suboptions: [build(:suboption)]))
    render
  }

  it "should show option attributes" do
    expect(rendered).to match(/Lunch/)     # professor name
    expect(rendered).to match(/sub/)   # option text
    expect(rendered).to match(/true/)     # option text
    expect(rendered).to match(/Atividade/)     # option text
  end
end
