require 'rails_helper'

RSpec.describe "professors/edit.html.erb", type: :view do
  before(:each) {
    assign(:professor, build(:professor, id: 2) )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
