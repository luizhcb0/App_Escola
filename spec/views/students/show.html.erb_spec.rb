require 'rails_helper'

RSpec.describe "students/show.html.erb", type: :view do
  before(:each) {
    assign(:student, build(:student, id:2))
    render
  }

  it "should show school atributes" do
    expect(rendered).to match(/Diretora/)     # person name
    expect(rendered).to match(/Pai/)          # father_name
    expect(rendered).to match(/Mae/)          # mother_name
  end
end
