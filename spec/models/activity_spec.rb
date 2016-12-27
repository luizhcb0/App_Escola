require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:activity_category) }
    it { should have_many(:options) }
    it { should have_and_belong_to_many(:classrooms) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the options of this activity" do
      option = create(:option)
      activity = option.activity
      expect(activity).to be_persisted
      activity.destroy
      expect(Option.all).to_not include option
    end
  end
end
