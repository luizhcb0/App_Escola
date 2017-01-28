require 'rails_helper'

RSpec.describe "activities/new.html.erb", type: :view do
  before(:each) {
    assign(:activity, Activity.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
