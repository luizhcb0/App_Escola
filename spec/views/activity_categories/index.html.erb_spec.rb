require 'rails_helper'

RSpec.describe "activity_categories/index.html.erb", type: :view do
  before(:each) {
    create(:activity_category, name: "Cat1")
    create(:activity_category, name: "Cat2")
    assign(:activity_categories, ActivityCategory.all)
    render
  }

  it "should display all activity_categories" do
    expect(rendered).to match(/Cat1/)
    expect(rendered).to match(/Cat2/)
  end
end
