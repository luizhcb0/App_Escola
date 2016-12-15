require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:users) }
  end

  describe "#with_role" do
    let(:user) { User.new }

    it "should return the user" do
      expect(user.with_role("role")).to eq user
    end

    it "should set the user with the correspondent role name" do
      create(:role)
      expect(user.with_role("role").role).to eq Role.find_by(name: "role")
    end

    it "should create and set user with the role name if it didnt exist" do
      expect(user.with_role("role2").role).to eq Role.find_by(name: "role2")
    end
  end
end
