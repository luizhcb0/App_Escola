require 'rails_helper'

RSpec.describe "students/show.html.erb", type: :view do
  before(:each) {
    assign(:student, build(:student, id:2))
    assign(:user, build(:user))
    render
  }

  it "should show students atributes" do
    expect(rendered).to match(/Student/)     # name
  end

  it "should show user atributes" do
    expect(rendered).to match(/User/)     # name
  end

  it "should render user_show partial" do
    expect(view).to render_template(:partial => "_user_show")
  end
end
