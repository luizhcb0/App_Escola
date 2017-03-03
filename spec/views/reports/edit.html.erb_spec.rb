require 'rails_helper'

RSpec.describe "reports/edit.html.erb", type: :view do
  before(:each) {
    assign(:report, build(:report, id: 2) )
    assign(:categories, ActivityCategory.all )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form_categories")
  end
end
