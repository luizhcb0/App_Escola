require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:text) }
  end

  describe "Associations" do
    it { should belong_to(:professor) }
    it { should have_and_belong_to_many(:students) }
  end
end
