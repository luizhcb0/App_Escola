require 'rails_helper'

RSpec.describe "activities/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:activity, create(:activity))
    render
  }

  it "should show activity attributes" do
    expect(rendered).to match(/Atividade/)     # professor name
  end
end
