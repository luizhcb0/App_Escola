require 'rails_helper'

RSpec.describe ActivityCategory, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:activities) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the activities of this category" do
      activity = create(:activity)
      category = activity.activity_category
      expect(category).to be_persisted
      category.destroy
      expect(Activity.all).to_not include activity
    end

    it "should delete the options of this category activities" do
      option = create(:option)
      category = option.activity.activity_category
      expect(category).to be_persisted
      category.destroy
      expect(Option.all).to_not include option
    end
  end
end
