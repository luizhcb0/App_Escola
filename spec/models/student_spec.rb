require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_attachment_content_type(:avatar).
                allowing('image/jpeg', 'image/gif', 'image/png').
                rejecting('text/plain', 'text/xml') }
  end

  describe "Attachments" do
    it { should have_attached_file(:avatar) }
  end

  describe "Attributes" do
    it "should not be absent" do
      student = create(:student)
      expect(student.absence).to be false
    end
  end

  describe "Associations" do
    it { should have_many(:reports) }
    it { should have_many(:student_users).dependent(:destroy) }
    it { should have_many(:users) }
    it { should have_and_belong_to_many(:classrooms) }
    it { should have_many(:message_students) }
    it { should have_many(:messages) }
  end

  describe "Delete - Associations consistency" do
    it "should delete the users of the student" do
      user = create(:user)
      student = create(:student, users: [user])
      expect(student.reload.users.size).to eq 1
      student.destroy
      expect(User.all).to_not include user
    end

    it "should delete reports of the student" do
      student = create(:student)
      report = create(:report, student: student)
      expect(Report.all).to include report
      student.destroy
      expect(Report.all).to_not include report
    end
  end
end
