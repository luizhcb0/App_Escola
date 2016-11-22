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
end
