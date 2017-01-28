require 'rails_helper'

RSpec.describe "options/new.html.erb", type: :view do
  before(:each) {
    assign(:option, Option.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
