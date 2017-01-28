require 'rails_helper'

RSpec.describe "activity_categories/edit.html.erb", type: :view do
  before(:each) {
    assign(:activity_category, build(:activity_category, id: 2) )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
