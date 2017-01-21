require 'rails_helper'

RSpec.describe "reports/new.html.erb", type: :view do
  before(:each) {
    assign(:report, Report.new )
    assign(:categories, ActivityCategory.all )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
