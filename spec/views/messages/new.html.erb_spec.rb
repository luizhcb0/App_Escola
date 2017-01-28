require 'rails_helper'

RSpec.describe "messages/new.html.erb", type: :view do
  before(:each) {
    professor = create(:professor)
    assign(:current_user, professor.user)
    assign(:message, Message.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
