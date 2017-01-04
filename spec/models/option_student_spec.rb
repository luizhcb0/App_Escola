require 'rails_helper'

RSpec.describe OptionStudent, type: :model do
  describe "Associations" do
    it { should belong_to(:option) }
    it { should belong_to(:student) }
  end

  # Tests just to show how it works
  describe "Notes tests" do
    it "should be able to take notes" do
      option = create(:option)
      student = create(:student, options: [option])
      # Proving
      expect(student.option_students.first).to_not be nil
      # This is how you save the option_student.notes field:
      opt_std = student.option_students.first
      opt_std.note = "texto de teste"
      opt_std.save
      # Showing that it works:
      expect(opt_std.note).to eq "texto de teste"
      expect(student.reload.option_students.first.note).to eq "texto de teste"
      # This is how you get the option_student object:
      expect(OptionStudent.where(
        option_id: option.id, student_id: student.id).first.note).to eq "texto de teste"
    end
  end
end
