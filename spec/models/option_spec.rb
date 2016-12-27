require 'rails_helper'

RSpec.describe Option, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:activity) }
    it { should have_many(:option_students) }
    it { should have_many(:students) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to options from students" do
      option = create(:option)
      student = create(:student, options: [option])
      expect(student.reload.options.size).to eq 1
      option.destroy
      expect(student.reload.options.size).to eq 0
    end
  end
end
