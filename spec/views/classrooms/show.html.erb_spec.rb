require 'rails_helper'

RSpec.describe "classrooms/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:classroom, create(:classroom, professors: [create(:professor)]))
    render
  }

  it "should show classroom attributes" do
    expect(rendered).to match(/User/)         # classroom name
    expect(rendered).to match(/Matutino/)     # classroom text
  end
end
