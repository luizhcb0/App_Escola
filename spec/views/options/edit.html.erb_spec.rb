require 'rails_helper'

RSpec.describe "options/edit.html.erb", type: :view do
  before(:each) {
    assign(:option, build(:option, id: 2) )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
