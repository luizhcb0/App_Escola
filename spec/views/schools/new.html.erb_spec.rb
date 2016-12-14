require 'rails_helper'

RSpec.describe "schools/new.html.erb", type: :view do
  before(:each) {
    assign(:school, School.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end

  it "should render person_fields partial" do
    expect(view).to render_template(:partial => "_person_fields")
  end

  it "should render user_fields partial" do
    expect(view).to render_template(:partial => "_user_fields")
  end

end
