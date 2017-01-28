require 'rails_helper'

RSpec.describe "activities/edit.html.erb", type: :view do
  before(:each) {
    assign(:activity, build(:activity, id: 2) )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
