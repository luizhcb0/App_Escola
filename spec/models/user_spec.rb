require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
    it { expect(build(:user)).to validate_uniqueness_of(:email) }
  end

  describe "Associations" do
    it { should have_one(:professor) }
    it { should have_many(:student_users) }
    it { should have_many(:students) }
  end
end
