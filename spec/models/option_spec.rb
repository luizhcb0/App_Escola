require 'rails_helper'

RSpec.describe Option, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    # it {should validate_inclusion_of(:multiple).in_array([true, false]) }
  end

  describe "Associations" do
    it { should belong_to(:activity) }
    it { should have_many(:suboptions) }
    it { should accept_nested_attributes_for(:suboptions) }
  end

  # describe "Callbacks" do
  #   it "before_create" do
  #     suboption = create(:suboption)
  #     option = create(:option, suboptions:[suboption])
  #     option.run_callbacks(:create) {false}
  #     expect(option.suboptions.first.activity_id).to eq option.activity_id
  #   end
  #
  #   it "before_update" do
  #     suboption = create(:option)
  #     option = create(:option, suboptions:[suboption])
  #     option.update(activity_id: 5)
  #     option.run_callbacks(:update) {false}
  #     expect(option.suboptions.first.activity_id).to eq option.activity_id
  #   end
  # end

  describe "Delete - Associations consistency" do
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
