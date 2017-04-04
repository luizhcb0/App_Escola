require 'rails_helper'

RSpec.describe "reports/new.html.erb", type: :view do
  before(:each) {
    view.extend SessionsHelper
    assign(:report, Report.new )
    assign(:categories, ActivityCategory.all )
    classroom = create(:classroom)
    assign(:current_user, classroom.user)
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
