require 'rails_helper'

RSpec.describe "professors/new.html.erb", type: :view do
  before(:each) {
    assign(:professor, Professor.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end

  it "should render person_fields partial" do
    expect(view).to render_template(:partial => "_person_fields")
  end

  it "should render login_fields partial" do
    expect(view).to render_template(:partial => "_login_fields")
  end
end
