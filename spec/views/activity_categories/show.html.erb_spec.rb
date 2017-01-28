require 'rails_helper'

RSpec.describe "activity_categories/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:activity_category, create(:activity_category))
    render
  }

  it "should show activity_category attributes" do
    expect(rendered).to match(/Categoria/)     # professor name
  end
end
