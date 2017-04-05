require 'rails_helper'

RSpec.describe School, type: :model do
  # describe "Validations" do
  #   it { should validate_presence_of(:name) }
  # end

  describe "Associations" do
    it { should belong_to(:user).dependent(:destroy) }
  end

  describe "Delete - Associations consistency" do
    let(:school) { create(:school) }

    it "should not let principal be destroied" do
      principal = school.user
      expect(principal).to be_persisted
      expect{ principal.destroy }.to raise_error ActiveRecord::InvalidForeignKey
      expect(school.user).to eq principal
    end
  end
end
