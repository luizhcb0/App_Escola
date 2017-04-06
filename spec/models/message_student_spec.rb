require 'rails_helper'

RSpec.describe MessageStudent, type: :model do
  describe "Associations" do
    it { should belong_to(:message) }
    it { should belong_to(:student) }
  end
end
