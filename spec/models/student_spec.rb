require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:option_students) }
    it { should have_many(:options) }
    it { should have_many(:student_users) }
    it { should have_many(:users) }
    it { should have_and_belong_to_many(:classrooms) }
    it { should have_and_belong_to_many(:messages) }
  end
end
