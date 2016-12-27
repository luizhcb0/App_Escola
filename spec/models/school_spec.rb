require 'rails_helper'

RSpec.describe School, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:professor).dependent(:destroy) }
  end

  describe "Delete - Associations consistency" do
    let(:school) { create(:school) }

    it "should delete the principal" do
      principal = school.professor
      expect(principal).to be_persisted
      school.destroy
      expect(Professor.all).to_not include principal
    end

    it "should delete the principal user" do
      principal_user = school.professor.user
      expect(principal_user).to be_persisted
      school.destroy
      expect(User.all).to_not include principal_user
    end

    it "should delete the principal messages" do
      message = create(:message, professor: school.professor)
      expect(school.professor.messages.size).to eq 1
      school.destroy
      expect(Message.all).to_not include message
    end
  end
end
