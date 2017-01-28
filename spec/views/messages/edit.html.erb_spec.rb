require 'rails_helper'

RSpec.describe "messages/edit.html.erb", type: :view do
  before(:each) {
    professor = create(:professor)
    assign(:message, build(:message, id: 2) )
    assign(:current_user, professor.user)
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
