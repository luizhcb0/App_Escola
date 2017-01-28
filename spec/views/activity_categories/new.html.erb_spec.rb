require 'rails_helper'

RSpec.describe "activity_categories/new.html.erb", type: :view do
  before(:each) {
    assign(:activity_category, ActivityCategory.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
