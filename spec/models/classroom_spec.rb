require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe "Validations" do
    # it { should validate_presence_of(:name) }
    it { should validate_presence_of(:shift) }
  end

  describe "Associations" do
    it { should have_and_belong_to_many(:activities) }
    it { should have_many(:professors) }
    it { should have_and_belong_to_many(:students) }
  end
end
