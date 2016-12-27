require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe "Associations" do
    it { should belong_to(:user).dependent(:delete) }
    it { should have_one(:school) }
    it { should have_many(:messages) }
    it { should have_and_belong_to_many(:classrooms) }
  end

  describe "Delete - Associations consistency" do
    let(:professor) { create(:professor) }

    it "should delete the professor user" do
      user = professor.user
      expect(user).to be_persisted
      professor.destroy
      expect(User.all).to_not include user
    end

    it "should delete the professor messages" do
      message = create(:message, professor: professor)
      expect(professor.messages.size).to eq 1
      professor.destroy
      expect(Message.all).to_not include message
    end
  end
end
