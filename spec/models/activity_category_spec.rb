require 'rails_helper'

RSpec.describe ActivityCategory, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:activities) }
  end
end
