require 'rails_helper'

RSpec.describe Option, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:activity) }
    it { should have_many(:option_students) }
    it { should have_many(:students) }
    it { should have_many(:suboptions) }
    it { should accept_nested_attributes_for(:suboptions) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the references to options from students" do
      option = create(:option)
      student = create(:student, options: [option])
      expect(student.reload.options.size).to eq 1
      option.destroy
      expect(student.reload.options.size).to eq 0
    end

    it "should delete references to suboptions from options" do
      option = create(:option)
      suboption = create(:suboption, option: option)
      option.destroy
      expect(Option.all).to_not include option
      expect(Suboption.all).to_not include suboption
    end
  end

  describe "Consistency" do
    it "should have saved parent and child" do
      option_child = create(:suboption)
      option = create(:option, suboptions: [option_child])
      option.save
      expect(Option.all).to include option
      expect(Suboption.all).to include option_child
    end
  end

end
