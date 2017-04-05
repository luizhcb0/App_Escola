require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe "Associations" do
    it { should belong_to(:classroom) }
  end

  describe "Delete - Associations consistency" do
    let(:professor) { create(:professor) }

    it "should set professor class to nil" do
      classroom = professor.classroom
      expect(classroom).to be_persisted
      classroom.destroy
      expect(professor.reload.classroom).to eq nil
    end
  end

end
