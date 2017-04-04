require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:text) }
  end

  describe "Associations" do
    it { should belong_to(:classroom) }
    it { should have_many(:message_students) }
    it { should have_many(:students) }
  end
end
