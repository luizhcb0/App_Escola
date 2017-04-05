require 'rails_helper'

RSpec.describe "messages/new.html.erb", type: :view do
  before(:each) {
    view.extend SessionsHelper
    classroom = create(:classroom)
    assign(:current_user, classroom.user)
    assign(:message, Message.new )
    render
  }

  it "should render form" do
    expect(view).to render_template(:partial => "_form")
  end
end
