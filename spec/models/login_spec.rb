require 'rails_helper'

RSpec.describe Login, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
  end

  describe "Associations" do
    it { should have_one(:professor) }
    it { should have_many(:student_logins) }
    it { should have_many(:students) }
  end
end
